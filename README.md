![eureka-optimizer](./img/eureka-optimizerPNG.png)

eureka-optimizer: An innovative ML-powered compiler that transforms your code into optimized, high-performance binaries. By combining neural prediction with traditional compilation, it automatically suggests and applies optimizations to improve runtime performance and reduce binary size.

> **Platform support:** Windows only. Linux/macOS requires additional workarounds and is not officially supported yet.

## Requirements

- Rust stable (MSVC toolchain)
- [CMake 3.20+](https://cmake.org/download/)
- C++17 compatible compiler
- LLVM 18 compiled with `/MD` (dynamic release runtime)
- [Visual Studio Build Tools 2022](https://visualstudio.microsoft.com/visual-cpp-build-tools/) with the following components:
  - Desktop development with C++
  - MSVC v143 (or later)
  - Windows 10/11 SDK
  - CMake tools for Windows

## Building

Set the `LLVM_SYS_181_PREFIX` environment variable to your LLVM installation path before building:

```powershell
$env:LLVM_SYS_181_PREFIX = "C:\llvm\build"
cargo build
```

If you compiled LLVM with different flags, the linker will fail with LNK2038.
In that case, recompile LLVM with:

```cmake
-DLLVM_USE_CRT_RELEASE=MD
-DLLVM_USE_INTEL_JITEVENTS=ON
```

> `LLVM_USE_INTEL_JITEVENTS` enables VTune profiling support. Requires
> [Intel VTune Profiler](https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html)
> to be installed.

## Usage

```powershell
cargo run -- --load-ir /path/to/program.ll
```

Outputs a JSON with IR features.

## Contributing

Contributions are welcome! Please note that this project is still in early stages, so expect breaking changes and rough edges. Feel free to open issues and pull requests.

## License

MIT — see [LICENSE](./LICENSE) for details.