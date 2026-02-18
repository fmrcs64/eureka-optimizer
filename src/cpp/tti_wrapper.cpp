#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/TargetParser/Host.h"
#include "llvm-c/Core.h"

#include <iostream>
#include <memory>

using namespace llvm;

static TargetMachine* create_target_machine() {
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();
    InitializeNativeTargetAsmParser();

    std::string target_triple = sys::getDefaultTargetTriple();
    std::string error;

    const Target* target = TargetRegistry::lookupTarget(target_triple, error);
    if (!target) {
        std::cerr << "Error looking up target: " << error << std::endl;
        return nullptr;
    }

    TargetMachine* TM = target->createTargetMachine(
        target_triple,
        sys::getHostCPUName().str(),
        "",
        TargetOptions(),
        std::nullopt,
        std::nullopt,
        CodeGenOptLevel::Default,
        false
    );

    if (!TM) {
        std::cerr << "Error creating TargetMachine" << std::endl;
        return nullptr;
    }

    return TM;
}

extern "C" {
    int get_instruction_cost(LLVMValueRef inst_ref) {
        static std::unique_ptr<TargetMachine> TM(create_target_machine());
        if (!TM) return -1;

        Instruction* I = unwrap<Instruction>(inst_ref);
        if (!I) return -1;

        Function* F = I->getFunction();
        if (!F) return -1;

        TargetTransformInfo TTI = TM->getTargetTransformInfo(*F);

        auto cost = TTI.getInstructionCost(
            I,
            TargetTransformInfo::TCK_RecipThroughput
        );

        if (cost.isValid()) {
            return static_cast<int>(*cost.getValue());
        }

        return -1;
    }
}