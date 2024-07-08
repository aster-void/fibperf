import { setTimeout } from "timers/promises";
import dotenv from "dotenv";
dotenv.config();

const sleep = (process.env.SLEEP ?? 0) * 1000;
const count = process.env.COUNT ?? 10;

const result = fib(count);
console.log(result);

function fib(count) {
  if (sleep !== 0) {
    console.log(`running fib(${count})`);
    setTimeout(sleep);
  }
  if (count <= 1) {
    return count;
  }
  const one = fib(count - 1);
  const two = fib(count - 2);
  return one + two;
}

