#!/usr/bin/env bash

./prepare.sh

export TIMEFORMAT='%3Rs'

export COUNT=42
export SLEEP_BETWEEN=0

# lewor the threshold because green thread runtimes are better at handling these tasks
export DISPATCH_THRESHOLD=25

echo "--------------------------------------"
echo "| Benchmarking Green thread runtimes |"
echo "--------------------------------------"
echo

echo "Go with channels:"
time (cd green/go && ./fib > /dev/null)
echo

echo "Rust Tokio:"
time (cd green/tokio && ./fib > /dev/null)
echo

exit

echo "------------------------------------"
echo "| Benchmarking Red thread runtimes |"
echo "------------------------------------"
echo

export DISPATCH_THRESHOLD=37

echo "Node.js with Workers:"
time (cd red/nodejs && node main.js > /dev/null)
echo

echo "Rust with std::thread:"
time (cd red/rust && ./fib > /dev/null)
echo

echo "Gleam with gleam/otp/task:"
time (cd red/gleam && gleam run --target erlang > /dev/null)
echo

echo "---------------------------------------"
echo "| Benchmarking Single thread runtimes |"
echo "---------------------------------------"
echo

# I don't know how to run compiled gleam
echo "Gleam:"
time (cd single/gleam && gleam run --target erlang > /dev/null) 
echo 

echo "Node.js:"
time (cd single/nodejs && node main.mjs > /dev/null)
echo 

echo "Node.js with async/await:"
time (cd single/nodejs && node main.mjs > /dev/null)
echo

echo "Single-thread Go:"
time (cd single/go && ./fib > /dev/null)
echo

echo "Rust:"
time (cd single/rust && ./fib > /dev/null)
echo

echo "Clang:"
time (cd single/clang && ./fib > /dev/null)
echo

echo "GCC:"
time (cd single/gcc && ./fib > /dev/null)
echo
