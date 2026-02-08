#include <stdio.h>

// Fibonacci iterativo (RÁPIDO)
int fibonacci(int n) { 
    if (n <= 1) return n;
    int a = 0, b = 1, c;
    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}

int main() {
    int result = 0;
    
    // Loop que força trabalho real
    for (int i = 0; i < 1000000; i++) {  // Ajuste esse número
        result += fibonacci(i % 30); // Limitar para evitar overflow
    }
    
    printf("Result: %d\n", result);
    return 0;
}