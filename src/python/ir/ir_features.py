import llvmlite.binding as llvm
import llvmlite.ir as ir
import re

def get_ir_features(ir_file):
     # file extension check
     if not ir_file.endswith('.ll'):
         raise ValueError("Input file must be a .ll file")
     
     # open validated file
     with open(ir_file, 'r') as f:
        ir_code = f.read() 

        # feature extraction logic
        features = {
        'num_functions': ir_code.count('define '),
        'num_instructions': len(re.findall(r'  %', ir_code)),
        'num_branches': ir_code.count('br i1'),
        'num_calls': ir_code.count('call '),
        'num_loads': ir_code.count('load '),
        'num_stores': ir_code.count('store ')
    }
        return features
     if not ir_file:
         raise FileNotFoundError(f"File not found: {ir_file}")