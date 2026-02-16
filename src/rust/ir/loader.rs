use anyhow::Result;
use std::path::Path;
use inkwell::context::Context;
use inkwell::module::Module;
use inkwell::memory_buffer::MemoryBuffer;

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

    Ok(module)
}