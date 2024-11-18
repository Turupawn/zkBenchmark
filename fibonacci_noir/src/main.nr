// Define the Fibonacci function using an array
unconstrained fn fibonacci(n: Field) -> Field {
    // If n is 0 or 1, return n directly
    let mut retValue = 0;
    if (n == 0) {
        retValue = n;
    } else if(n == 1) {
        retValue = n;
    } else {
        // Initialize an array to hold the Fibonacci sequence
        let mut fib = [0; 100];  // assuming a maximum of 100 elements for simplicity
        fib[0] = 0;
        fib[1] = 1;

        // Calculate Fibonacci numbers up to n iteratively
        for i in 2..1000 {
            let y = i as Field;
            if(n==y) {
                break;
            }
            fib[i] = fib[i - 1] + fib[i - 2];
        }

        // Return the nth Fibonacci number
        retValue = fib[n];
    }
    retValue
}

// Main circuit to compute Fibonacci of a given number
fn main(n: pub Field) -> pub Field {
    fibonacci(n)
}
