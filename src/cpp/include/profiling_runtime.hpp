// TODO: Implement TSC Calibration and VM Detection
#pragma once

#include <cstdint>
#include <atomic>

struct ProbeProfile {
   std::atomic<uint64_t> exec_count{0};
   std::atomic<uint64_t> total_cycles{0};
   std::atomic<uint64_t> cache_misses{0};
   std::atomic<uint64_t> branch_misses{0};
};

// TODO: ETW/PMU for ARM64 Support
#if defined(_WIN32) && \
(defined(__i386__) || defined(_M_IX86) || defined(_M_X64) || defined(__x86_64__)) // WIN32 covers WIN64 as well, x86-64 support

#if defined(HAVE_VTUNE)
#include "llvm/ExecutionEngine/JITEventListener.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
void register_vtune_listener(llvm::orc::LLJIT *JIT) {
    auto *listener = llvm::JITEventListener::createIntelJITEventListener();
    if (listener)
        JIT->registerJITEventListener(*listener);
}
#endif

#include <intrin.h>
// Thread Pinning and Affinity with native APIs
#include <windows.h>
    inline void pin_to_core(int core) {
        SetThreadAffinityMask(GetCurrentThread(), 1ULL << core);
    }
// Prevent inlining via __declspec(noinline) and __attribute__((noinline)) to ensure accurate cycle counts at function entry and exit.
// MSVC?
#if defined(_MSC_VER)
// TODO: CPUID check CPUID.80000001H:EDX[bit 27] (RDTSCP support)   
    __declspec(noinline)
    static uint64_t read_cycle_counter_x86() {
        #if defined(USE_ENTRY_FENCE)
    _mm_lfence();
        #endif
    unsigned int aux;
        uint64_t tsc = __rdtscp(&aux);
        (void)aux;
        return tsc;
}
    // GNUC/Clang?
    #elif defined(__GNUC__) || defined(__clang__)
    __attribute__((noinline))
    static uint64_t read_cycle_counter_x86() {
        uint32_t hi, lo;
        // LFENCE ensures serialization of instructions before reading TSC, preventing out-of-order execution issues.
        __asm__ volatile ("lfence" ::: "memory"); // Serialize Entry
        __asm__ volatile ("rdtscp" : "=a"(lo), "=d"(hi) : : "rcx"); // RDTSCP accounts for CPUID barriers via LFENCE.
        // Serialize Exit ommited due to slight ~50 cycles accuracy loss.

        return ((uint64_t)hi << 32) | lo; // higher bit, lower bit
    }

    // Unsupported compiler
    #else
        #error "Unsupported compiler/architecture for x86 cycle counter"
    #endif 
    #endif

// #undef __linux__
#if defined(__linux__)
   #warning "Platform not supported: Profiling is not yet implemented for this architecture."   
#endif

#if defined(__APPLE__)
    #warning "Platform not supported: Profiling is not yet implemented for this architecture."
#endif

