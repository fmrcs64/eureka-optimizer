#include <stdio.h>

// Fibonacci recursivo (LENTO)
int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int result = 0;
    
    // Loop que força trabalho real
    for (int i = 0; i < 35; i++) {  // Ajuste esse número
        result += fibonacci(i);
    }
    
    printf("Result: %d\n", result);
    return 0;
}