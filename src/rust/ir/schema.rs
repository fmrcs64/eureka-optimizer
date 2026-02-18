use serde::Serialize;

use crate::ir::extract_features::{IRGraph, Node};

#[derive(Default, Serialize)]
pub struct IRSchema {
    pub function: Vec<FunctionFeatures>,
    pub basic_block: Vec<BasicBlockFeatures>,
    pub instruction: Vec<InstructionFeatures>,
}

#[derive(Serialize)]
pub struct FunctionFeatures {
    pub arg_count: f32,
}

#[derive(Serialize)]
pub struct BasicBlockFeatures {
    pub pred_count: f32,
    pub succ_count: f32,
}

#[derive(Serialize)]
pub struct InstructionFeatures {
    pub cost: f32,
    pub raw_opcode_id: f32,
    pub operand_count: f32,
}

impl IRSchema {
    pub fn from_graph(graph: &IRGraph) -> Self {
        let mut schema = IRSchema {
            function: Vec::new(),
            basic_block: Vec::new(),
            instruction: Vec::new(),
        };

        schema.function.reserve(graph.nodes.len());
        schema.basic_block.reserve(graph.nodes.len());
        schema.instruction.reserve(graph.nodes.len());

        for node in &graph.nodes {
            match node {
                Node::Function { arguments } => {
                    schema.function.push(FunctionFeatures {
                        arg_count: arguments.len() as f32,
                    });
                }
                Node::BasicBlock {
                    pred_blocks,
                    succ_blocks,
                    ..
                } => {
                    schema.basic_block.push(BasicBlockFeatures {
                        pred_count: pred_blocks.len() as f32,
                        succ_count: succ_blocks.len() as f32,
                    });
                }
                Node::Instruction {
                    cost,
                    raw_opcode_id,
                    operand_count,
                    ..
                } => {
                    schema.instruction.push(InstructionFeatures {
                        cost: *cost,
                        raw_opcode_id: *raw_opcode_id as f32,
                        operand_count: *operand_count as f32,
                    });
                }
            }
        }

        schema
    }
}
