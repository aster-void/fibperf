#!/usr/bin/env bash

./prepare.sh

export COUNT=42
export SLEEP_BETWEEN=0
export DISPATCH_THRESHOLD=39

echo "--------------------------------------"
echo "| Benchmarking Green thread runtimes |"
echo "--------------------------------------"

echo "Benchmarking Go"
time (cd green/go && ./fib)
echo

echo "Benchmarking Tokio"
time (cd green/tokio && ./fib)
echo

echo "------------------------------------"
echo "| Benchmarking Red thread runtimes |"
echo "------------------------------------"

export DISPATCH_THRESHOLD=39

echo "Benchmarking Node.js Workers"
time (cd red/nodejs && node main.js)
echo

echo "Benchmarking Rust std::thread"
time (cd red/rust && ./fib)
echo

echo "---------------------------------------"
echo "| Benchmarking Single thread runtimes |"
echo "---------------------------------------"

# I don't know how to run compiled gleam
echo "Benchmarking Gleam"
time (cd single/gleam && gleam run --target erlang) 
echo 

echo "Benchmarking Node.js"
time (cd single/nodejs && node main.mjs)
echo 

echo "Benchmarking Node.js with async/await"
time (cd single/nodejs && node main.mjs)
echo

echo "Benchmarking Single-thread Go"
time (cd single/go && ./fib)
echo

echo "Benchmarking Rust"
time (cd single/rust && ./fib)
echo

echo "Benchmarking Clang"
time (cd single/clang && ./fib)
echo

echo "Benchmarking GCC"
time (cd single/gcc && ./fib)
echo
