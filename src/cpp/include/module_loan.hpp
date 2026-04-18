#pragma once
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"

using namespace llvm;
using namespace orc;
class ModuleLoan {
   public:
   // Never use without initializing JIT
     Expected<std::unique_ptr<Module>> removeModule(ThreadSafeModule *TSM) {
        // JITDylib &JD = Jit->getMainJITDylib();
        // auto RT = JD.getDefaultResourceTracker();
        return TSM->consumingModuleDo([](std::unique_ptr<Module> M) {
         return std::move(M);
        });
     }
   private:
      std::unique_ptr<LLJIT> Jit;
};
