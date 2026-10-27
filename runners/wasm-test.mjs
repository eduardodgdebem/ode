// Runs the tests in a module `ode test --target wasm32` built, in Node:
//
//   node wasm-test.mjs tests.wasm [filter]
//
// The module exports ode_test_count(), ode_test_name(i) and ode_test_run(i).
// Each test runs in an instance of its own, so a test that fails -- which
// traps -- leaves nothing behind for the next. A failed check calls the
// module's panic handler first, which prints where and why. What it prints,
// and its exit status, are those of a native `ode test`.

import { readFileSync } from "node:fs";

const [file, filter] = process.argv.slice(2);
const module = new WebAssembly.Module(readFileSync(file));
let memory = null;

// NUL-terminated text at `pointer` in the module's memory, or null.
function text(pointer) {
  if (pointer === 0 || memory === null) {
    return null;
  }
  const bytes = new Uint8Array(memory.buffer, pointer);
  return new TextDecoder().decode(bytes.subarray(0, bytes.indexOf(0)));
}

function panic(where, message) {
  const said = text(message);
  process.stderr.write(said === null ? `${text(where)}\n` : `${text(where)}: ${said}\n`);
}

// The test panic handler and a program's own are this runner's; anything
// else the module imports fails the test that calls it, saying what it was.
const env = new Proxy({ ode_test_panic: panic, panic }, {
  get(known, name) {
    if (name in known) {
      return known[name];
    }
    return () => {
      throw new Error(`the module imports '${String(name)}', which the wasm test runner does not provide`);
    };
  },
});

function instance() {
  const { exports } = new WebAssembly.Instance(module, { env });
  memory = exports.memory;
  return exports;
}

const count = instance().ode_test_count();
let passed = 0;
let failed = 0;
let skipped = 0;

for (let index = 0; index < count; index++) {
  const tests = instance();
  const name = text(tests.ode_test_name(index));
  if (filter !== undefined && !name.includes(filter)) {
    skipped++;
    continue;
  }
  try {
    tests.ode_test_run(index);
    process.stdout.write(`test ${name} ... ok\n`);
    passed++;
  } catch (error) {
    if (!(error instanceof WebAssembly.RuntimeError)) {
      process.stderr.write(`${error.message}\n`);
    }
    process.stdout.write(`test ${name} ... FAILED\n`);
    failed++;
  }
}

let summary = `\n${passed} passed; ${failed} failed`;
if (skipped > 0) {
  summary += `; ${skipped} filtered out`;
}
process.stdout.write(`${summary}\n`);
process.exitCode = failed > 0 ? 1 : 0;
