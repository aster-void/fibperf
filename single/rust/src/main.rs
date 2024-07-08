use std::env;

fn main() {
    let count = parse_env("COUNT").unwrap_or(10);
    println!("{}", fib(count));
}

fn parse_env(name: &str) -> Option<usize> {
    let var = env::var(name);
    if var.is_ok() {
        if let Ok(count) = var.unwrap().parse::<usize>() {
            return Some(count);
        }
    }
    return None;
}

fn fib(count: usize) -> usize {
    if count <= 1 {
        count
    } else {
        fib(count - 1) + fib(count - 2)
    }
}
