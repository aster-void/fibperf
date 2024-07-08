# fib in many languages

## Dependencies

- Gleam
- Erlang (if your package manager doesn't install automatically)
- Node.js
- Go
- Cargo
- GCC
- Clang

## Available runtimes

green:
- Go
- Tokio

red:
- Node.js with Worker + async/await
- Rust with std::thread

single:
- Node.js
- Node.js with async/await
- Rust
- Go
- Gleam (no env read) (no compile, runs gleam run)
- Clang C (no env read) (I'm not familiar with optimization flags)
- GCC C (no env read)

## How to see the results

(this part is all my guess)

the result of `time` command has 3 parts.

`real`: time it actually took.

`user`: total time each CPU core spent on the command.

`sys`: syscall? idk


## Directories

`green` contains green-threaded runtimes such as go and tokio.

`red` contains red-threaded (= OS thread) such as Node.js Worker API and Rust thread::spawn.

`single` contains single-threaded programs such as Node.js async/await.

## environment variables

COUNT stands for fib count. the program calculates fib($COUNT) where fib is the fibonacci function.
default: 10

DISPATCH_THRESHOLD decides where it should switch to syncronous functions for performance. when at 1, the performance is almost equal to when all functions are async. must be at least 1.
default: 1

SLEEP_BETWEEN is for debugging. it makes the recursive functions sleep for $SLEEP_BETWEEN seconds before calling one deeper function.
Note that it may or may not do anything on single thread.
default: 0
