// hi this is me from the future, you should have used llvm-ir instead of inkwell :P ``08/02/2026 at 15:58´´
use anyhow::Result;
use inkwell::context::Context;
use inkwell::memory_buffer::MemoryBuffer;
use inkwell::module::Module;
use inkwell::values::InstructionOpcode;
use serde::{Deserialize, Serialize};
use std::path::Path;

pub fn load_module<'ctx>(path: &str, context: &'ctx Context) -> Result<Module<'ctx>> {
    let path = Path::new(path);
    if !path.exists() {
        anyhow::bail!("IR file not found: {}", path.display());
    }
    let memory_buffer = MemoryBuffer::create_from_file(&path)
        .map_err(|e| anyhow::anyhow!("Failed to read IR file {}: {}", path.display(), e))?;
    let module = context
        .create_module_from_ir(memory_buffer)
        .map_err(|e| anyhow::anyhow!("Failed to parse IR file: {}", e))?;

    println!("Module loaded successfully from {}", path.display());
    Ok(module)
}
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct IRSchema {
    pub num_functions: usize,
    pub num_instructions: usize,
    pub num_calls: usize,
    pub num_branches: usize,
    pub num_stores: usize,
    pub num_loads: usize,
}

pub fn extract_features(module: &Module, schema: &mut IRSchema) {
    for function in module.get_functions() {
        schema.num_functions += 1;

        for block in function.get_basic_blocks() {
            for instruction in block.get_instructions() {
                schema.num_instructions += 1;

                match instruction.get_opcode() {
                    InstructionOpcode::Call => schema.num_calls += 1,
                    InstructionOpcode::Br => schema.num_branches += 1,
                    InstructionOpcode::Store => schema.num_stores += 1,
                    InstructionOpcode::Load => schema.num_loads += 1,
                    _ => {}
                }
            }
        }
    }
}

