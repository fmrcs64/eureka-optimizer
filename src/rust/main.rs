use clap::Parser;
use inkwell::context::Context;

mod ir;

#[derive(Parser, Debug)]
#[command(version, about)]
struct Args {
    #[arg(long)]
    load_ir: String,
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();

    let context = Context::create();
    let module = ir::loader::load_module(&args.load_ir, &context)?;

    println!(
        "Module loaded: {}",
        module.get_name().to_string_lossy()
    );

    let graph = ir::extract_features::IRGraph::from_module(&module);
    
    for (id, node) in graph.nodes.iter().enumerate() {
    let features = node.extract_features(&graph, id);
    println!("Node {}: features = {:?}", id, features.values);
}
    // TODO: schema.rs — serializar para JSON

    Ok(())
}