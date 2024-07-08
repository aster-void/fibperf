package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

func main() {
	s := os.Getenv("COUNT")
	var c int
	var err error
	c, err = strconv.Atoi(s)
	if err != nil {
		c = 5
	}
	fmt.Println(fib(c))
}

func fib(count int) int {
	ch := make(chan int, 1)
	fibasync(count, ch)
	return <-ch
}

// send to res once
func fibasync(count int, res chan int) {
	fmt.Printf("running fibasync(%d)\n", count)
	time.Sleep(1 * time.Second)
	if count <= 1 {
		res <- count
		return
	}
	ch := make(chan int, 2)
	go fibasync(count-1, ch)
	go fibasync(count-2, ch)
	res <- <-ch + <-ch
}
