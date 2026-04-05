use clap::Parser;
use inkwell::context::Context;
/*
use llvm_sys::orc2::{
    LLVMOrcCreateNewThreadSafeContext, 
    LLVMOrcCreateNewThreadSafeModule,
    LLVMOrcThreadSafeContextRef,
    LLVMOrcThreadSafeModuleRef,
    LLVMOrcDisposeThreadSafeContext,
    LLVMOrcDisposeThreadSafeModule,
};
*/
use std::fs::{self, File};
use std::io::BufWriter;
mod ir;
use ir::ffi;

#[derive(Parser, Debug)]
#[command(version, about)]
struct Args {
    #[arg(long)]
    load_ir: String,
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();

    let tsctx = ffi::create_tsctx();
    let ctx_ref = ffi::get_tsctx(tsctx);
    
    let context = unsafe { inkwell::context::ContextRef::new(ctx_ref)};
    let module = ir::loader::load_module(&args.load_ir, &context)?;

    println!(
        "Module loaded: {}",
        module.get_name().to_string_lossy()
    );
    let tsm = ffi::create_tsm(module.as_mut_ptr(), tsctx);
    let graph = ir::extract_features::IRGraph::from_module(&module);
    
    for (id, node) in graph.nodes.iter().enumerate() {
    let features = node.extract_features(&graph, id);
   // println!("Node {}: features = {:?}", id, features.values);
}
    let schema = ir::schema::IRSchema::from_graph(&graph);
    fs::create_dir_all("output")?;
    let output = File::create("output/ir_features.json")?;
    let mut writer = BufWriter::new(output);
    serde_json::to_writer_pretty(&mut writer, &schema).unwrap();
    println!("IR features extracted and saved raw JSON to output/ir_features.json");
    ffi::dispose_tsm(tsm);
    ffi::dispose_tsctx(tsctx);
    
    std::mem::forget(module);
    // ContextRef has no Drop trait
    Ok(())
}