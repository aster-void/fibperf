use std::env;
use std::thread;
use std::time::Duration;

fn main() {
    let count = parse_env("COUNT").unwrap_or(10);
    let sleep = parse_env("SLEEP_BETWEEN").unwrap_or(0);
    let threshold = parse_env("DISPATCH_THRESHOLD").unwrap_or(1);
    println!("{}", fib(count, sleep, threshold));
}

fn fib(count: usize, sleep: usize, threshold: usize) -> usize {
    if sleep != 0 {
        println!("fib({count})");
        thread::sleep(Duration::from_secs(sleep as u64));
    }
    if count <= threshold {
        fibsync(count)
    } else {
        let one = thread::spawn(move || fib(count - 1, sleep, threshold));
        let two = thread::spawn(move || fib(count - 2, sleep, threshold));
        one.join().unwrap() + two.join().unwrap()
    }
}

fn fibsync(count: usize) -> usize {
    if count <= 1 {
        count
    } else {
        fibsync(count - 1) + fibsync(count - 2)
    }
}

fn parse_env(name: &str) -> Option<usize> {
    let var = env::var(name);
    if var.is_ok() {
        if let Ok(var) = var.unwrap().parse::<usize>() {
            return Some(var);
        }
    }
    return None;
}
