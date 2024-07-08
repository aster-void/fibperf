package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"
)

var sleep uint
var threshold uint

func main() {
	count, err := parse_env("COUNT")
	if err != nil {
		count = 10
	}
	sleep, err = parse_env("SLEEP_BETWEEN")
	if err != nil {
		sleep = 0
	}
	threshold, err = parse_env("DISPATCH_THRESHOLD")
	if err != nil {
		// default to 1
		log.Fatalln(err)
	}
	fmt.Println(fib(count))
}

func fib(count uint) uint {
	ch := make(chan uint, 1)
	fibasync(count, ch)
	return <-ch
}

// send to res once
func fibasync(count uint, res chan uint) {
	if sleep != 0 {
		fmt.Printf("running fibasync(%d)\n", count)
		time.Sleep(1 * time.Second)
	}
	if count <= threshold {
		res <- fibsync(count)
		return
	}
	ch := make(chan uint, 2)
	go fibasync(count-1, ch)
	go fibasync(count-2, ch)
	res <- <-ch + <-ch
}

func fibsync(count uint) uint {
	if count <= 1 {
		return count
	}
	return fibsync(count-1) + fibsync(count-2)
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
