#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/TargetParser/Host.h"
#include "llvm-c/Core.h"

#include <iostream>
#include <memory>

using namespace std;
using namespace llvm;

static TargetMachine* create_target_machine() {
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();
    InitializeNativeTargetAsmParser();

    string target_triple = sys::getDefaultTargetTriple();
    string error;

    const Target* target = TargetRegistry::lookupTarget(target_triple, error);
    if (!target) {
        cerr << "Error looking up target: " << error << endl;
        return nullptr;
    }

    TargetMachine* TM = target->createTargetMachine(
        target_triple,
        "generic",
        "",
        TargetOptions(),
        std::nullopt,
        std::nullopt,
        CodeGenOptLevel::Default,
        false
    );

    if (!TM) {
        cerr << "Error creating TargetMachine" << endl;
        return nullptr;
    }

    return TM;
}

extern "C" {
    unsigned get_instruction_cost(LLVMValueRef inst_ref) {
        static unique_ptr<TargetMachine> TM(create_target_machine());
        if (!TM) return 0;

        Instruction* I = unwrap<Instruction>(inst_ref);
        if (!I) return 0;

        Function* F = I->getFunction();
        if (!F) return 0;

        TargetTransformInfo TTI = TM->getTargetTransformInfo(*F);
        auto cost = TTI.getInstructionCost(I, TargetTransformInfo::TCK_Latency);
        if (cost.isValid()) {
            return *cost.getValue();
        }
        return 0;
    }
}