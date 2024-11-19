pragma circom 2.0.0;

// Fibonacci with custom starting numbers
template Fibonacci(max) {
  assert(max >= 2);
  signal input n;
  signal input fibo_of_n;

  signal d; // Todo: Check this, Groth16 needs non linear constraints
  d <-- 1;

  signal fib[max+1];
  fib[0] <== 1;
  fib[1] <== 1;
  for (var i = 2; i <= max; i++) {
    fib[i] <== fib[i-2] + fib[i-1] * d;
  }

  assert(fib[n-1] == fibo_of_n);
  //log(fib[n-1]);
}

component main = Fibonacci(1000);