use cmake::Config;

fn main() {
    let dst = Config::new("src")
        .build_target("tti")
        .profile("Release")
        .define("CMAKE_MSVC_RUNTIME_LIBRARY", "MultiThreadedDLL")
        .build();

    println!("cargo:rustc-link-search=native={}",dst.join("build").display());
    println!("cargo:rustc-link-lib=static=tti");
}