const { setTimeout } = require("timers/promises");
const {
  Worker,
  workerData,
  parentPort,
  isMainThread,
} = require("worker_threads");

async function main() {
  const count = process.env.COUNT ?? 10;
  const sleep = (process.env.SLEEP_BETWEEN ?? 0) * 1000;
  const threshold = process.env.DISPATCH_THRESHOLD;
  const result = await splitWorkers({
    count,
    sleep,
    threshold,
  });
  console.log(result);
}

async function worker() {
  if (!workerData.threshold) throw new Error("no threshold: " + JSON.stringify(workerData))
  if (workerData.sleep !== 0) {
    console.log(`workerData.count === ${workerData.count}`);
    await setTimeout(workerData.sleep);
  }
  if (workerData.count <= workerData.threshold) {
    parentPort.postMessage(syncFib(workerData.count));
    return
  }
  const one = splitWorkers({
    count: workerData.count - 1,
    sleep: workerData.sleep,
    threshold: workerData.threshold,
  });
  const two = splitWorkers({
    count: workerData.count - 2,
    sleep: workerData.sleep,
    threshold: workerData.threshold,
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

function syncFib(count) {
  if (count <= 1) {
    return count
  }
  return syncFib(count - 1) + syncFib(count - 2);
}
