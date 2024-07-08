import {setTimeout} from "timers/promises"

async function fib(count) {
  console.log(`running fib(${count})`);
  await setTimeout(1000);
  if (count <= 1) {
    return count;
  }
  const one = fib(count - 1);
  const two = fib(count - 2);
  return await one + await two;
}

const result = await fib(5);
console.log(result);
