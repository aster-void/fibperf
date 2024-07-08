#!/usr/bin/env bash

export COUNT=32
export SLEEP_BETWEEN=0
export DISPATCH_THRESHOLD=24

echo "--------------------------------------"
echo "| Benchmarking Green thread runtimes |"
echo "--------------------------------------"

echo "Benchmarking Go"
time (cd green/go && go run .) # FIX THIS

echo "Benchmarking Tokio"
time (cd green/tokio && cargo run) # FIX THIS

echo "------------------------------------"
echo "| Benchmarking Red thread runtimes |"
echo "------------------------------------"

export DISPATCH_THRESHOLD=30

echo "Benchmarking Node.js Workers"
time (cd red/nodejs && node main.js)

echo "---------------------------------------"
echo "| Benchmarking Single thread runtimes |"
echo "---------------------------------------"

time (cd single/nodejs && node main.mjs)
