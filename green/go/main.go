package main

import (
	"errors"
	"fmt"
	"os"
	"strconv"
	"time"
)

func main() {
	count, err := parse_env("COUNT")
	if err != nil {
		count = 10
	}
	sleep, err := parse_env("SLEEP_BETWEEN")
	if err != nil {
		sleep = 0
	}
	fmt.Println(fib(count, sleep))
}

func fib(count uint, sleep uint) uint {
	ch := make(chan uint, 1)
	fibasync(count, ch, sleep)
	return <-ch
}

// send to res once
func fibasync(count uint, res chan uint, sleep uint) {
	if sleep != 0 {
		fmt.Printf("running fibasync(%d)\n", count)
		time.Sleep(1 * time.Second)
	}
	if count <= 1 {
		res <- count
		return
	}
	ch := make(chan uint, 2)
	go fibasync(count-1, ch, sleep)
	go fibasync(count-2, ch, sleep)
	res <- <-ch + <-ch
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
