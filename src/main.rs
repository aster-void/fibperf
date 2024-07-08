use futures::future::{BoxFuture, FutureExt};
use std::{env, time::Duration};
use tokio;

#[tokio::main]
async fn main() {
    let count = parse_env_count().unwrap_or(1000);
    println!("{}", fib(count).await);
}

fn parse_env_count() -> Option<usize> {
    let var = env::var("COUNT");
    if var.is_ok() {
        if let Ok(count) = var.unwrap().parse::<usize>() {
            return Some(count);
        }
    }
    return None;
}

fn fib(count: usize) -> BoxFuture<'static, usize> {
    async move {
        println!("running fib({count})");
        tokio::time::sleep(Duration::from_secs(1)).await;
        if count <= 1 {
            return count;
        }
        let one = tokio::spawn(fib(count - 1));
        let two = tokio::spawn(fib(count - 2));
        return one.await.unwrap() + two.await.unwrap();
    }
    .boxed()
}
