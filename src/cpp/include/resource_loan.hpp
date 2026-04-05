#pragma once
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"

using namespace llvm;
using namespace orc;
class ResourceLoan {
   public:
     Expected<std::unique_ptr<Module>> removeModule(ThreadSafeModule *TSM) {
        JITDylib &JD = Jit->getMainJITDylib();
        auto RT = JD.getDefaultResourceTracker();   
        // TODO: Transfer JIT Runtime artifacts to associated ResourceKey to RT within the same JITDyLib via FFI Safe Bindings for RustResourceTracker (RRT) and pass as opaque pointer to C++ side.
        // RT->transferTo(RRT);
     }
   private:
      std::unique_ptr<LLJIT> Jit;
};
