const { setTimeout } = require("timers/promises");
const {
  Worker,
  workerData,
  parentPort,
  isMainThread,
} = require("worker_threads");

async function main() {
  require("dotenv").config();
  const count = process.env.COUNT ?? 10;
  const sleep = (process.env.SLEEP_BETWEEN ?? 0) * 1000;
  const result = await splitWorkers({
    count,
    sleep,
  });
  console.log(result);
}

async function worker() {
  if (workerData.sleep !== 0) {
    console.log(`workerData.count === ${workerData.count}`);
    await setTimeout(workerData.sleep);
  }
  if (workerData.count <= 1) {
    parentPort.postMessage(workerData.count);
    return
  }
  const one = splitWorkers({
    count: workerData.count - 1,
    sleep: workerData.sleep,
  });
  const two = splitWorkers({
    count: workerData.count - 2,
    sleep: workerData.sleep,
  });
  parentPort.postMessage(await one + await two);
}

if (isMainThread) {
  main();
} else {
  worker();
}

function splitWorkers(workerData) {
  return new Promise((resolve, reject) => {
    const worker = new Worker(__filename, {
      workerData,
    });
    worker.on('message', resolve);
    worker.on('error', reject);
    worker.on('exit', (code) => {
      if (code !== 0)
        reject(new Error(`Worker stopped with exit code ${code}`));
    });
  })
}
