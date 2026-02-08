// hi from future-self again, just a reminder to stop vibe coding serde and actually read docs ``08/02/2026 at 17:15´´
use clap::Parser;
use serde::{Deserialize, Serialize};
use serde_json::to_writer;
use std::fs::File;

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

    let features = ir::extract_features::extract_features(&module);
    let schema = ir::extract_features::IRSchema {
        num_functions: features.num_functions,
        num_instructions: features.num_instructions,
        num_calls: features.num_calls,
        num_branches: features.num_branches,
        num_stores: features.num_stores,
        num_loads: features.num_loads,
    };
    let file = File::create("ir_features.json")?;
    let mut writer = std::io::BufWriter::new(file);
    serde_json::to_writer_pretty(&mut writer, &schema)?;

    println!("=== Extracted IR Features ===");
    println!("Functions     : {}", features.num_functions);
    println!("Instructions  : {}", features.num_instructions);
    println!("Calls         : {}", features.num_calls);
    println!("Branches      : {}", features.num_branches);
    println!("Loads         : {}", features.num_loads);
    println!("Stores        : {}", features.num_stores);
    Ok(())
}
