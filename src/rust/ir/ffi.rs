use inkwell::llvm_sys::prelude::LLVMValueRef;
use inkwell::values::InstructionValue;
use inkwell::values::AsValueRef;
use inkwell::values::InstructionOpcode;

use llvm_sys::orc2::*;
use llvm_sys::prelude::LLVMContextRef;
use llvm_sys::prelude::LLVMModuleRef;

extern "C" {
    fn get_instruction_cost(inst: LLVMValueRef) -> i32;
    fn instrument_module(module: inkwell::llvm_sys::prelude::LLVMModuleRef) -> i32;
}

pub fn instruction_cost(inst: InstructionValue) -> f32 {
    let raw = unsafe { get_instruction_cost(inst.as_value_ref()) };
    raw as f32
    /*
   match raw {
      n if n >= 0 => n as f32,
      _           => invalid_cost_fallback(inst.get_opcode()),
   }
    */
} 

pub fn run_instrumentation(module: &inkwell::module::Module) {
    unsafe { instrument_module(module.as_mut_ptr()); }
}
//tsctx
pub fn create_tsctx() -> LLVMOrcThreadSafeContextRef {
   unsafe {
     LLVMOrcCreateNewThreadSafeContext()
   }
}

pub fn get_tsctx(tsctx: LLVMOrcThreadSafeContextRef) -> LLVMContextRef {
    unsafe {
        LLVMOrcThreadSafeContextGetContext(tsctx)
    }
}

pub fn dispose_tsctx(tsctx: LLVMOrcThreadSafeContextRef) {
    unsafe {
        LLVMOrcDisposeThreadSafeContext(tsctx);
    }
}
// tsm
pub fn create_tsm(module: LLVMModuleRef, ctx: LLVMOrcThreadSafeContextRef) -> LLVMOrcThreadSafeModuleRef {
    unsafe {
        LLVMOrcCreateNewThreadSafeModule(module, ctx)
    }
}

pub fn dispose_tsm(tsm: LLVMOrcThreadSafeModuleRef) {
    unsafe {
        LLVMOrcDisposeThreadSafeModule(tsm);
    }
}
/*
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
*/