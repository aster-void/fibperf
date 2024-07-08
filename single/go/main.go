package main

import (
	"errors"
	"fmt"
	"os"
	"strconv"
)

func main() {
	count, err := parse_env("COUNT")
	if err != nil {
		count = 10
	}
	fmt.Println(fib(count))
}

func parse_env(name string) (uint, error) {
	s := os.Getenv(name)
	i, err := strconv.Atoi(s)
	if err != nil {
		return 0, err
	}
	if i < 0 {
		return 0, errors.New("negative value")
	}
	return uint(i), nil
}

func fib(c uint) uint {
	if c <= 1 {
		return c
	}
	return fib(c-1) + fib(c-2)
}
