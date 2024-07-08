#!/usr/bin/env bash

cd `dirname -- $0`

export COUNT=10
export SLEEP_BETWEEN=1

echo "Testing Go.."
(cd go && go run .)

echo "Testing Node.js..."
(cd nodejs && node main.mjs)

echo "Testing Tokio..."
(cd tokio && cargo run .)
