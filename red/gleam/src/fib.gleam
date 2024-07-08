import gleam/int
import gleam/io
import gleam/list
import gleam/otp/task

// import gleam/os

const count = 42

const threshold = 30

pub fn main() {
  io.println(int.to_string(fib(count)))
}

fn fib(count: Int) -> Int {
  case count {
    _ if count <= 1 -> count
    _ if count <= threshold -> fibsync(count)
    _ -> {
      [count - 1, count - 2]
      |> list.map(fn(c) { task.async(fn() { fib(c) }) })
      |> list.map(task.await_forever)
      |> int.sum
    }
  }
}

fn fibsync(count: Int) -> Int {
  case count {
    _ if count <= 1 -> count
    _ -> fibsync(count - 1) + fibsync(count - 2)
  }
}
