use inkwell::llvm_sys::prelude::LLVMValueRef;
use inkwell::values::InstructionValue;
use inkwell::values::AsValueRef;
use inkwell::values::InstructionOpcode;

extern "C" {
    fn get_instruction_cost(inst: LLVMValueRef) -> i32;
}

pub fn instruction_cost(inst: InstructionValue) -> f32 {
    let raw = unsafe { get_instruction_cost(inst.as_value_ref()) };
    match raw {
        n if n >= 0 => n as f32,
        _           => invalid_cost_fallback(inst.get_opcode()),
    }
}

fn invalid_cost_fallback(opcode: InstructionOpcode) -> f32 {
    use InstructionOpcode::*;
    match opcode {
        SDiv | SRem | UDiv | URem => 25.0,  
        Call                      => 10.0,
        Load                      => 4.0,
        Store                     => 1.0,
        _                         => 1.0,
    }
}