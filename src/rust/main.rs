use clap::Parser;
use serde_json;
use std::fs::File;
use std::path::PathBuf;

mod ir;

#[derive(Parser, Debug)]
#[command(version, about)]
struct Args {
    #[arg(long)]
    load_ir: String,
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();

    let context = inkwell::context::Context::create();

    let module = ir::extract_features::load_module(&args.load_ir, &context)?;

    println!(
        "Module loaded successfully: {}",
        module.get_name().to_string_lossy()
    );
    let mut schema = ir::extract_features::IRSchema::default();
    ir::extract_features::extract_features(&module,&mut schema);
    let output_dir = PathBuf::from("output");
    std::fs::create_dir_all(&output_dir)?;
    let file = File::create("output/ir_features.json")?;
    let mut writer = std::io::BufWriter::new(file);
    serde_json::to_writer_pretty(&mut writer, &schema)?;

    println!("=== Extracted IR Features ===");
    println!("Functions     : {}", schema.num_functions);
    println!("Instructions  : {}", schema.num_instructions);
    println!("Calls         : {}", schema.num_calls);
    println!("Branches      : {}", schema.num_branches);
    println!("Loads         : {}", schema.num_loads);
    println!("Stores        : {}", schema.num_stores);
    Ok(())
}
