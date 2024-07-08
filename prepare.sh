#!/usr/bin/env bash

# build, compile, and optimize.

(
  cd green/go
  go build -o fib -ldflags="-s -w" .
)
(
  cd green/tokio
  cargo build --release
  cp target/release/fib .
)
