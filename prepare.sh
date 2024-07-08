#!/usr/bin/env bash

# build, compile, and optimize.
function setup_rust () {
  cargo build --release
  cp target/release/fib .
}
function setup_go() {
  go build -o fib -ldflags="-s -w" .
}
(
  cd green/go
  setup_go
)
(
  cd green/tokio
  setup_rust
)
(
  cd red/rust
  setup_rust
)
(
  cd single/go
  setup_go
)
(
  cd single/rust
  setup_rust
)
