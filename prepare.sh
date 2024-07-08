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
  # precompile gleam s.t. gleam run can read from cache
  cd red/gleam
  gleam build
)
(
  # precompile gleam s.t. gleam run can read from cache
  cd single/gleam
  gleam build
)
(
  cd single/go
  setup_go
)
(
  cd single/rust
  setup_rust
)
(
  cd single/clang
  clang main.c -o fib -O3
)
(
  cd single/gcc
  gcc main.c -o fib -O3
)
