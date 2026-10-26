# Ownership and safety

Read for ownership, resource lifetime, concurrent or async behavior, unsafe code,
or FFI. Prioritize demonstrated failure paths over mechanical style findings.

## Borrowing and resource lifetime

- Start with the lifetime and ownership the contract needs. Shorten borrows, split
  independent field access, or use mem::take/replace and Option::take when a value
  should move out of mutable state. Check what state remains if later work fails.
- A clone may correctly provide an independent snapshot or cheap shared ownership.
  Remove it only after checking aliasing, mutation visibility, lifetime, and cost.
  Do not replace a clear small clone with Rc<RefCell<_>> to avoid copying.
- Owned fields often simplify lifetimes; borrowed fields are appropriate for views,
  parsers, and other real borrowing contracts. Avoid speculative lifetime machinery
  and avoid copying large input solely to eliminate a lifetime annotation.
- Use Drop guards for cleanup on early return and unwinding. Bind a guard to a
  named variable; let _ = acquire_guard() drops the returned guard immediately.
  A wildcard matching an existing binding does not move or drop it. Check destructor
  order, partial initialization, and whether guards outlive the work they protect.
- Choose iterators, matches, combinators, and loops by clarity. Measure allocation
  or copying costs before optimizing; preserve deterministic output where promised.

## Concurrency and async

- Check actual executor and caller requirements before requiring Send or Sync.
  Single-threaded runtimes and local futures may intentionally use Rc or RefCell.
  A RefCell borrow held across await can still cause a runtime borrow panic when
  another local task accesses the cell. Preserve promised auto traits in public
  types and returned futures.
- Inspect lock scope and ordering, reentrancy through user callbacks, and guards
  held across await. Determine whether a guard blocks executor progress or creates a
  deadlock; an async-aware guard across await is not automatically incorrect.
  Returning a guard can be a deliberate API, with documented lifetime constraints.
- Trace cancellation at await points: dropped futures may abandon partial state,
  consume messages, or leave external work running. Check task ownership, error
  propagation, shutdown, backpressure, and bounded queues where relevant.
- Keep blocking I/O and long CPU-bound work off executor threads using the runtime's
  supported mechanisms. spawn_blocking is not automatically cancellable; yielding
  alone does not fix every CPU-bound workload. Do not prescribe arbitrary intervals.
- Do not introduce channels, shared state, a runtime, or spawned tasks unless they
  fit the existing ownership and scheduling model.

## Unsafe and FFI

- Prefer safe standard/library APIs when they meet the contract. For unsafe code,
  identify and justify validity, alignment, initialization, aliasing, provenance,
  lifetime, and thread-safety obligations as applicable. A SAFETY comment records
  the argument; its presence is not evidence that the argument is true.
- Inspect every safe entry point and mutation that can invalidate an unsafe
  invariant. Keep the soundness boundary small enough to audit. An unsafe fn needs
  explicit caller obligations; safe wrappers must enforce them for safe callers.
- Check unsafe Send/Sync implementations against all reachable states and shared
  operations. Do not use transmute or lifetime extension to conceal invalid ownership.
- At FFI boundaries, verify ABI and layout, pointer validity and nullability,
  string representation, allocator ownership, callback lifetimes, and teardown.
  Use repr(C) or repr(transparent) where the specific ABI contract requires it.
- Establish the permitted unwind behavior for the chosen ABI. Do not let Rust
  panics cross a boundary that forbids unwinding. Rust 1.81+ aborts on an uncaught
  Rust panic escaping extern "C"; older toolchains must not rely on that guarantee.
  extern "C-unwind" (Rust 1.71+) permits unwinding. catch_unwind only catches
  unwinding Rust panics, not aborts, and does not make foreign exceptions safe.
  Validate error translation and cleanup rather than mechanically inserting a catch.
- Use targeted tests, Miri, or fuzzing for the affected invariants when practical.
  Miri cannot execute most foreign calls. A passing run covers exercised paths,
  not every possible execution or platform.

For edition 2024 migrations, check unsafe extern blocks, unsafe attributes such as
#[unsafe(no_mangle)], the unsafe_op_in_unsafe_fn warning, and the static_mut_refs
deny-by-default lint. std::env::set_var and remove_var become unsafe in this edition;
their process-wide effects need a real safety argument, not just an unsafe block.
These changes do not imply every existing extern block or environment call should
be rewritten outside an authorized migration.

## Sources

- [Rust Design Patterns](https://rust-unofficial.github.io/patterns/): ownership,
  RAII, idioms, and tradeoffs.
- [Effective Rust](https://www.lurklurk.org/effective-rust/): lifetimes, Drop,
  concurrency, async, and unsafe code.
- [Google Rust Style Guide](https://google.github.io/styleguide/rustguide.html):
  unsafe practices and maintainable Rust conventions.
- [Rustonomicon](https://doc.rust-lang.org/nomicon/): detailed unsafe and FFI
  obligations; consult it for a soundness argument beyond this summary.
- [Rust Edition Guide](https://doc.rust-lang.org/edition-guide/rust-2024/):
  edition-specific migration requirements.

Adapted from BeautifulRust; the pinned revision and license are in the skills
directory's README.md and LICENSE. These notes are a curated summary, not verbatim
rules or a substitute for the original sources.
