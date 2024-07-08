# fib in many languages

## Directories

`green` contains green-threaded runtimes such as go and tokio.

`red` contains red-threaded (= OS thread) such as Node.js Worker API and Rust thread::spawn.

`single` contains single-threaded programs such as Node.js async/await.

## environment variables

COUNT stands for fib count. the program calculates fib($COUNT) where fib is the fibonacci function.

DISPATCH_THRESHOLD decides where it should switch to syncronous functions for performance. when at 1, the performance is almost equal to when all functions are async. must be at least 1.

SLEEP_BETWEEN is for debugging. it makes the recursive functions sleep for $SLEEP_BETWEEN seconds before calling one deeper function
Note that it may or may not do anything on single thread.

