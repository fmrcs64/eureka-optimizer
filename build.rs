// link tti_wrapper.cpp, which provides a C-compatible interface to LLVM's TTI APIs
use std::process::Command;

fn main() {

    let llvm_cxxflags = Command::new("llvm-config")
        .arg("--cxxflags")
        .output()
        .expect("llvm-config not found — is LLVM 18 installed?");

    let llvm_ldflags = Command::new("llvm-config")
        .arg("--ldflags")
        .output()
        .expect("llvm-config not found");

    let llvm_libs = Command::new("llvm-config")
        .arg("--libs")
        .arg("analysis")
        .arg("target")
        .arg("x86")
        .output()
        .expect("llvm-config not found");

    let cxxflags = String::from_utf8(llvm_cxxflags.stdout).unwrap();
    let ldflags  = String::from_utf8(llvm_ldflags.stdout).unwrap();
    let libs     = String::from_utf8(llvm_libs.stdout).unwrap();

    let mut build = cc::Build::new();
    build
        .cpp(true)
        .file("src/cpp/tti_wrapper.cpp")
        .flag("-std=c++17");

    for flag in cxxflags.split_whitespace() {
        build.flag(flag);
    }

    build.compile("tti_wrapper");

    for flag in ldflags.split_whitespace() {
        if let Some(path) = flag.strip_prefix("-L") {
            println!("cargo:rustc-link-search=native={}", path);
        }
    }

    for lib in libs.split_whitespace() {
        if let Some(name) = lib.strip_prefix("-l") {
            println!("cargo:rustc-link-lib={}", name);
        }
    }

    #[cfg(not(target_os = "windows"))]
    println!("cargo:rustc-link-lib=stdc++");
    println!("cargo:rerun-if-changed=src/cpp/tti_wrapper.cpp");
}