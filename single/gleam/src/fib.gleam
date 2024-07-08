import gleam/int
import gleam/io

// import gleam/os

pub fn main() {
  let count = 42
  io.println(int.to_string(fib(count)))
}

fn fib(count: Int) -> Int {
  case count <= 1 {
    True -> count
    False -> fib(count - 1) + fib(count - 2)
  }
}
