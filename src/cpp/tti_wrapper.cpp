#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/PassManager.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/TargetParser/Host.h"
#include "llvm/TargetParser/SubtargetFeature.h"
#include "llvm/Transforms/IPO/SampleProfileProbe.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/ExecutionEngine/Orc/ObjectLinkingLayer.h"

#include "include/profiling_runtime.hpp"

#include <fstream>
#include <memory>

using namespace llvm;

// Global ProbeProfile instance
ProbeProfile g_instr_cost_profile;

static TargetMachine* get_tm() {
    static std::unique_ptr<TargetMachine> TM([] {
        InitializeNativeTarget();

        std::string triple = sys::getDefaultTargetTriple();
        std::string error;

        const Target* target = TargetRegistry::lookupTarget(triple, error);
        if (!target) return (TargetMachine*)nullptr; // Maybe an error here later

        SubtargetFeatures F;
        F.getDefaultSubtargetFeatures(Triple(triple));

        return target->createTargetMachine(
            triple,
            sys::getHostCPUName().str(),
            F.getString(),
            TargetOptions(),
            Reloc::PIC_,
            std::nullopt,
            CodeGenOptLevel::Default,
            /*JIT*/ false
        );
    }());

    return TM.get();
}

// IRCostSemanticsV1 — versioned cost struct, ICS-2 planned
struct IRCostSemanticsV1 {
    float latency;
};

extern "C" {

    int instrument_module(LLVMModuleRef mod_ref) {
        Module* M = unwrap(mod_ref);
        if (!M) return -1;

        TargetMachine* TM = get_tm();
        if (!TM) return -1;

        M->addModuleFlag(Module::Warning, "EnablePseudoProbeInst", 1);

        ModuleAnalysisManager MAM;
        PassBuilder PB(TM);
        PB.registerModuleAnalyses(MAM);

        ModulePassManager MPM;
        // TODO: add BFI pass here to reduce granularity when available
        MPM.addPass(SampleProfileProbePass(TM));
        MPM.run(*M, MAM);
        
        return 0;
    }
    llvm::Error profile_module(LLVMModuleRef mod_ref) {
      Module* M = unwrap(mod_ref);
      if(!M) return make_error<StringError>("Module not found", inconvertibleErrorCode()); // Avoid converting to std::error_code()
      //ThreadSafeModule optional, C++/FFI side doesn't cause any lifetime concerns   
      // auto JIT = orc::LLJITBuilder().create();
      // if(!JIT) return JIT.takeError();
      
    }


    int get_instruction_cost(LLVMValueRef instr_ref) {
        Instruction* I = unwrap<Instruction>(instr_ref);
        if (!I) return -1;

        TargetMachine* TM = get_tm();
        if (!TM) return -1;

        Function* F = I->getFunction();
        if (!F) return -1;

        TargetTransformInfo TTI = TM->getTargetTransformInfo(*F);

     //  uint64_t start = read_cycle_counter_x86();
       auto cost = TTI.getInstructionCost(I, TargetTransformInfo::TCK_Latency);
     //  uint64_t elapsed = read_cycle_counter_x86() - start;

      // g_instr_cost_profile.exec_count.fetch_add(1, std::memory_order_relaxed);
      // g_instr_cost_profile.total_cycles.fetch_add(elapsed, std::memory_order_relaxed);

        {
            std::ofstream dbg("tti_debug.txt", std::ios::app);
            dbg << I->getOpcodeName() << " = ";
            if (cost.isValid())
                dbg << *cost.getValue();
            else
                dbg << "invalid";
            dbg << "\n";
        }

        if (!cost.isValid()) return -1;

        return (int)*cost.getValue();
    }

    // TODO: implement vector instruction cost
    int get_vector_instruction_cost() {
        return 0;
    }

} // extern "C"