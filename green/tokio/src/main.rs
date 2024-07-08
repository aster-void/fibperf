use futures::future::{BoxFuture, FutureExt};
use std::{env, time::Duration};
use tokio;

#[tokio::main]
async fn main() {
    let sleep = parse_env("SLEEP_BETWEEN").unwrap_or(0);
    let count = parse_env("COUNT").unwrap_or(10);
    let threshold = parse_env("DISPATCH_THRESHOLD").unwrap_or(1);
    println!("{}", fib(count, sleep, threshold).await);
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

fn fib(count: usize, sleep: usize, threshold: usize) -> BoxFuture<'static, usize> {
    async move {
        if sleep != 0 {
            println!("running fib({count})");
            tokio::time::sleep(Duration::from_secs(1)).await;
        }
        if count <= threshold {
            return fibsync(count);
        }
        let one = tokio::spawn(fib(count - 1, sleep, threshold));
        let two = tokio::spawn(fib(count - 2, sleep, threshold));
        return one.await.unwrap() + two.await.unwrap();
    }
    .boxed()
}
fn fibsync(count: usize) -> usize {
    if count <= 1 {
        count
    } else {
        fibsync(count - 1) + fibsync(count - 2)
    }
}
