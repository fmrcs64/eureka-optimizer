import subprocess
import time
from pathlib import Path
from ir_features import get_ir_features

def compile_to_ir(source_file, output_ir, opt_flag):
    """Compila C para LLVM IR"""
    subprocess.run([
        'clang', 
        opt_flag, 
        '-S', '-emit-llvm', 
        source_file, 
        '-o', output_ir
    ], check=True)

def compile_to_binary(source_file, output_binary, opt_flag):
    """Compila C para executável"""
    subprocess.run([
        'clang',
        opt_flag,
        source_file,
        '-o', output_binary
    ], check=True)

def measure_execution_time(binary, iterations=10):
    """Executa binário N vezes e retorna tempo médio"""
    times = []
    for _ in range(iterations):
        start = time.perf_counter()
        subprocess.run([binary], check=True)
        elapsed = time.perf_counter() - start
        times.append(elapsed)
    
    return sum(times) / len(times)

def main():

    results_dir = Path("C:/Users/user/eureka-optimizer/benchmarks")
    results_dir.mkdir(parents=True, exist_ok=True)
    
    source = 'examples/recursive_fibonacci.c'
    flags = ['-O0', '-O2', '-O3']
    results = []
    
    for flag in flags:
        print(f"\n=== Testing {flag} ===")
        
        ir_file = results_dir / f'benchmark{flag}.ll'
        compile_to_ir(source, str(ir_file), flag)
 
        features = get_ir_features(str(ir_file))
        print(f"Features: {features}")

        binary = f'benchmark{flag}.exe'
        compile_to_binary(source, binary, flag)

        exec_time = measure_execution_time(binary)
        print(f"Execution time: {exec_time:.4f}s")

        results.append({
            'flag': flag,
            'features': features,
            'time': exec_time
        })
    
    baseline_time = results[0]['time']
    
    print("\n=== RESULTS ===")
    for r in results:
        speedup = baseline_time / r['time']
        print(f"{r['flag']}: {speedup:.2f}x speedup")

if __name__ == "__main__":
    main()