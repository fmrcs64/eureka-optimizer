use std::collections::HashMap;
use inkwell::module::Module;
use inkwell::llvm_sys::core::{LLVMGetNumSuccessors, LLVMGetSuccessor, LLVMGetInstructionOpcode};
use inkwell::values::InstructionOpcode;
use inkwell::values::AsValueRef;
use crate::ir::ffi;

pub struct IRGraph {
    pub nodes: Vec<Node>,
    pub edge: Vec<Edge>,
    pub metadata: HashMap<usize, IRNodeMetadata>,
}

pub struct Edge {
    from: usize,
    to: usize,
    kind: usize,
}

pub struct IRNodeMetadata; // TODO: Define metadata fields as needed

pub enum Node {
    Function {
        arguments: Vec<String>,
    },
    BasicBlock {
        name: String,
        pred_blocks: Vec<usize>,
        succ_blocks: Vec<usize>,
    },
    Instruction {
        opcode: InstructionOpcode,
        raw_opcode_id: u32,                        
        operand_count: usize,
        cost: f32, 
    },
}

pub struct FeatureVector {
    pub values: Vec<f32>,
}

impl Node {
    pub fn extract_features(&self, _graph: &IRGraph, _node_id: usize) -> FeatureVector {
        match self {
            Node::Function { arguments } => {
                //#[cfg(debug_assertions)]
               // println!("Extracted features for Function: arguments={:?}", arguments);
                FeatureVector {
                    values: vec![arguments.len() as f32],
                }
            }
            Node::BasicBlock { name, pred_blocks, succ_blocks } => {
                // #[cfg(debug_assertions)]
               // println!("Extracted features for BasicBlock: name={}", name);
                let pred_count = pred_blocks.len() as f32;
                let succ_count = succ_blocks.len() as f32;
                // values: [pred_count, succ_count, is_entry, is_exit]
                FeatureVector {
                    values: vec![
                        pred_count,
                        succ_count,
                        (pred_count == 0.0) as u8 as f32, // is_entry
                        (succ_count == 0.0) as u8 as f32, // is_exit
                    ],
                }
            }
            Node::Instruction { opcode, raw_opcode_id, operand_count, cost } => {
             //   #[cfg(debug_assertions)]
            //    println!("Extracted features for Instruction: opcode={:?}, operand_count={}, cost={}", opcode, operand_count, cost);
                FeatureVector {
                    values: vec![
                        *cost as f32,                 
                        *raw_opcode_id as f32,
                        *operand_count as f32,
                    ]
                }
            }
        }
    }
}
impl IRGraph {
    pub fn from_module(module: &Module<'_>) -> Self {
        ffi::run_instrumentation(module);
        let mut graph = IRGraph {
            nodes: Vec::new(),
            edge: Vec::new(),
            metadata: HashMap::new(),
        };

        const EDGE_FN_TO_BLOCK: usize = 0;
        const EDGE_BLOCK_TO_INST: usize = 1;
        const EDGE_BLOCK_TO_BLOCK_CFG: usize = 2;

        for function in module.get_functions() {
            let function_idx = graph.nodes.len();
            graph.nodes.push(Node::Function {
                arguments: function
                    .get_param_iter()
                    .map(|p| p.get_name().to_string_lossy().to_string())
                    .collect(),
            });

            let blocks = function.get_basic_blocks();
            let mut block_idx_by_ref: HashMap<usize, usize> = HashMap::with_capacity(blocks.len());
            let mut block_indices: Vec<usize> = Vec::with_capacity(blocks.len());

            for block in &blocks {
                let block_idx = graph.nodes.len();
                graph.nodes.push(Node::BasicBlock {
                    name: block.get_name().to_string_lossy().to_string(),
                    pred_blocks: Vec::new(),
                    succ_blocks: Vec::new(),
                });
                block_idx_by_ref.insert(block.as_mut_ptr() as usize, block_idx);
                block_indices.push(block_idx);
                graph.edge.push(Edge {
                    from: function_idx,
                    to: block_idx,
                    kind: EDGE_FN_TO_BLOCK,
                });
            }

            let mut preds_by_block_idx: HashMap<usize, Vec<usize>> =
                HashMap::with_capacity(blocks.len());
            let mut succs_by_block_idx: HashMap<usize, Vec<usize>> =
                HashMap::with_capacity(blocks.len());

            for (block, &block_idx) in blocks.iter().zip(block_indices.iter()) {
                for instruction in block.get_instructions() {
                    let inst_idx = graph.nodes.len();
                    let raw_opcode_id = unsafe {
                        LLVMGetInstructionOpcode(instruction.as_value_ref()) as u32
                    };
                    graph.nodes.push(Node::Instruction {
                        opcode: instruction.get_opcode(),
                        raw_opcode_id,
                        operand_count: instruction.get_num_operands() as usize,
                        cost: ffi::instruction_cost(instruction),
                    });
                    graph.edge.push(Edge {
                        from: block_idx,
                        to: inst_idx,
                        kind: EDGE_BLOCK_TO_INST,
                    });
                }

                if let Some(terminator) = block.get_terminator() {
                    let term_ref = terminator.as_value_ref();
                    let succ_count = unsafe { LLVMGetNumSuccessors(term_ref) };
                    let succs = succs_by_block_idx
                        .entry(block_idx)
                        .or_insert_with(|| Vec::with_capacity(succ_count as usize));

                    for i in 0..succ_count {
                        let succ_ref = unsafe { LLVMGetSuccessor(term_ref, i) } as usize;
                        if let Some(&succ_idx) = block_idx_by_ref.get(&succ_ref) {
                            succs.push(succ_idx);
                            preds_by_block_idx
                                .entry(succ_idx)
                                .or_default()
                                .push(block_idx);
                            graph.edge.push(Edge {
                                from: block_idx,
                                to: succ_idx,
                                kind: EDGE_BLOCK_TO_BLOCK_CFG,
                            });
                        }
                    }
                }
            }

            for &block_idx in &block_indices {
                if let Node::BasicBlock {
                    pred_blocks,
                    succ_blocks,
                    ..
                } = &mut graph.nodes[block_idx]
                {
                    *pred_blocks = preds_by_block_idx.remove(&block_idx).unwrap_or_default();
                    *succ_blocks = succs_by_block_idx.remove(&block_idx).unwrap_or_default();
                }
            }
        }

        graph
    }
}