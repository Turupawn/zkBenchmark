use risc0_zkvm::guest::env;

// Function to calculate the nth Fibonacci number
fn fibonacci(n: u32) -> u32 {
    if n == 0 {
        0
    } else if n == 1 {
        1
    } else {
        let mut a = 0;
        let mut b = 1;
        for _ in 2..=n {
            let temp = a + b;
            a = b;
            b = temp;
        }
        b
    }
}

fn main() {
    // TODO: Implement your guest code here

    // read the input
    let input: u32 = env::read();

    let result: u32 = fibonacci(input);

    eprintln!("Fibonacci of {} is {}", input, result);

    // TODO: do something with the input

    // write public output to the journal
    env::commit(&result);
}
