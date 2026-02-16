use inkwell::llvm_sys::prelude::LLVMValueRef;
use inkwell::values::InstructionValue;
use inkwell::values::AsValueRef;

extern "C" {
    fn get_instruction_cost(inst: LLVMValueRef) -> u32;
}

pub fn instruction_cost(inst: InstructionValue) -> u32 {
    unsafe { get_instruction_cost(inst.as_value_ref()) }
}