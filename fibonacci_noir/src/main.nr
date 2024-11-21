unconstrained fn fibonacci(n: Field) -> Field {
    let mut retValue = 0;
    if (n == 0) {
        retValue = n;
    } else if(n == 1) {
        retValue = n;
    } else {
        let mut fib = [0; 1000]; // Max value for n is 1000
        fib[0] = 0;
        fib[1] = 1;

        for i in 2..1000 {
            let y = i as Field;
            if(n==y) {
                break;
            }
            fib[i] = fib[i - 1] + fib[i - 2];
        }
        retValue = fib[n];
    }
    retValue
}

fn main(n: pub Field) -> pub Field {
    fibonacci(n)
}