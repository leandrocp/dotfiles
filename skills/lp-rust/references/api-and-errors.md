# API and errors

Read for public API design, error contracts, or API-focused review. These are
contextual defaults, not a mandate to redesign existing code.

## Types and ownership at the boundary

- Use enums for mutually exclusive states and newtypes for meaningful distinctions
  or validated invariants. Add them when they prevent a real mistake, not for every
  primitive. A constructor must validate any invariant the type promises.
- Borrow when only reading; take ownership when storing or consuming. Prefer &str,
  &[T], and &Path to references to owned containers when their extra capabilities
  are unnecessary. Choose generic conversion parameters only when they help callers.
- Public fields are appropriate for passive data; private fields protect invariants
  and allow representation changes. Arc, Box, and other ownership types may belong
  in a public contract when sharing, dynamic dispatch, or ownership is intentional.
- Use concrete types for straightforward application code. Add traits, generics,
  trait objects, and builders for actual caller needs, not hypothetical flexibility.
  Consider an enum instead of a bool when call sites are ambiguous or modes evolve.
- Implement standard traits when their semantics fit. Debug must redact secrets;
  Clone and Copy must respect resource ownership. Default should represent a useful
  default, not invent an invalid value merely because new() exists.
- PartialEq, Eq, Ord, PartialOrd, and Hash must agree. Equal keys must hash equally;
  Ord must agree with PartialOrd and PartialEq. Custom Ord beside derived equality
  is valid only if cmp returns Equal exactly when the derived == holds. Borrow<Q>
  lookups require the borrowed and owned types' equality, hashing, and ordering
  semantics to agree as applicable.
- Prefer From/TryFrom implementations to direct Into/TryInto implementations, and
  FromStr for conventional string parsing. Use checked conversions when truncation,
  wrapping, or sign loss would violate the contract; casts are not categorically bugs.

## Errors and panics

- Use Option for ordinary absence and Result when a caller needs failure information.
  Expected invalid input should not unexpectedly panic. Assess unwrap, expect,
  indexing, arithmetic, and conversions against reachable inputs and invariants,
  rather than flagging their spelling alone.
- Choose library errors around what consumers need to inspect and recover from;
  implement Display and the appropriate core/std Error trait where supported. Preserve
  useful causes and context without leaking credentials or sensitive input. Concrete
  error types often help stable APIs; erased errors can be a deliberate contract.
  Check Send + Sync + 'static requirements when consumers transfer errors between
  threads or box them behind those bounds. core::error::Error requires Rust 1.81+.
- Application error reporting may use the project's existing anyhow/eyre-style
  approach. Do not introduce a dependency or hierarchy for its own sake.
- An intentional panic should explain the violated invariant. Do not silently change
  a panic into an error during behavior-preserving cleanup. Poisoned-lock recovery
  requires reestablishing protected invariants; neither recovery nor aborting is a
  universal policy. Follow the application's failure model.
- Make fallible shutdown explicit when callers must observe failure. Drop cannot
  return an error; avoid panicking during unwinding and surprising blocking cleanup.

## Evolution and documentation

Before changing visibility, field construction, enum variants, trait bounds, trait
implementations, auto traits, or dyn compatibility, inspect downstream compatibility.
Choose non_exhaustive or sealed traits only when their extensibility tradeoff fits.
Public third-party types can intentionally expose an ecosystem integration; check
dependency/version coupling rather than banning them outright.
Use the project's cargo-semver-checks setup when available; tooling supplements
inspection of behavioral compatibility rather than proving it.

Document caller-relevant invariants, ownership transfer, error cases, reachable
panics, and safety obligations. Use runnable rustdoc examples and useful intra-doc
links. Do not require cosmetic documentation rewrites outside the requested scope.

## Sources

- [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/): API conventions,
  interoperability, documentation, and future-proofing.
- [Cargo SemVer guide](https://doc.rust-lang.org/cargo/reference/semver.html):
  compatibility implications of public API changes.
- [Effective Rust](https://www.lurklurk.org/effective-rust/): types, conversions,
  errors, traits, and visibility.
- [Microsoft Pragmatic Rust Guidelines](https://microsoft.github.io/rust-guidelines/):
  API design, error handling, and application/library distinctions.

Adapted from BeautifulRust; the pinned revision and license are in the skills
directory's README.md and LICENSE. These notes are a curated summary, not verbatim
rules or a substitute for the original sources.
