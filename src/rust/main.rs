use clap::Parser;
use inkwell::context::Context;
use std::fs::{self, File};
use std::io::BufWriter;

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
   // println!("Node {}: features = {:?}", id, features.values);
}
    let schema = ir::schema::IRSchema::from_graph(&graph);
    fs::create_dir_all("output")?;
    let output = File::create("output/ir_features.json")?;
    let mut writer = BufWriter::new(output);
    serde_json::to_writer_pretty(&mut writer, &schema).unwrap();
    println!("IR features extracted and saved raw JSON to output/ir_features.json");
    Ok(())
}