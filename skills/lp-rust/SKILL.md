---
name: lp-rust
description: "Provides Rust-specific design, implementation, and review guidance. Use when the task substantively involves Rust source or Rust-specific Cargo configuration, alongside the selected workflow skill. Not for unrelated work merely because the repository contains Rust."
license: MIT
---

# Rust

Supply Rust-specific judgment, not another workflow. Apply only to the Rust portion
of the requested task.

## Fit the task and project

Read applicable repository guidance, nearby Rust code, Cargo manifests, toolchain
configuration, and CI before recommending changes. Establish the edition, declared
minimum supported Rust version (MSRV), target platforms, supported feature sets,
runtime, and whether the affected API has external consumers. Do not infer a public
library contract solely from the existence of lib.rs. If MSRV is unspecified, do not
invent one or silently raise the compiler requirement.

Repository contracts and explicit task constraints take precedence over preferences
in these references. Distinguish correctness and soundness requirements from API
conventions and style. Preserve established patterns unless the requested change
requires otherwise; explain a concrete consequence before proposing a departure.

## Work alongside the selected lp- skill

- **lp-plan:** use Rust ownership, error, API, and compatibility constraints when
  comparing designs. Do not introduce implementation or extra approval gates.
- **lp-build:** apply the relevant Rust guidance while making the requested change.
  Keep application code direct; do not impose reusable-library machinery on it.
- **lp-polish:** simplify ownership and idioms without changing public signatures,
  public trait implementations, panic behavior, errors, or output contracts.
- **lp-code-review:** inspect Rust-specific failure modes, then use that skill's
  evidence standards, finding identifiers, severity, and report format. A guideline
  violation alone is not a demonstrated defect; cite a rule only when it supports
  the finding, and distinguish optional improvements from bugs.

This skill starts no workflow stages; the selected skill's own chaining rules still
apply. The selected workflow owns scope, testing strategy, reporting, and
authorization. This skill grants no permission to edit during a review, install
tools, alter lint policy, or publish changes.

## Read only the relevant reference

- [API and errors](references/api-and-errors.md): public types, trait contracts,
  ownership in signatures, error design, documentation, and compatibility.
- [Ownership and safety](references/ownership-and-safety.md): borrowing and clones,
  resource lifetimes, concurrency, async cancellation, unsafe code, and FFI.

For Cargo-only work, focus on toolchain, dependency, target, and feature compatibility;
do not load unrelated API or unsafe guidance. Consult the [Cargo Book](https://doc.rust-lang.org/cargo/),
especially [features](https://doc.rust-lang.org/cargo/reference/features.html) and
[rust-version](https://doc.rust-lang.org/cargo/reference/rust-version.html).
Edition 2024 implies resolver 3, which considers declared Rust versions when
selecting dependencies; virtual workspaces must select the resolver explicitly.
Consult linked original sources when condensed advice cannot settle a decision.

## Select Rust checks from the actual contract

Use the repository's existing commands and CI matrix. When no commands are defined,
consider cargo fmt --check, cargo check, cargo clippy, cargo test, and cargo doc
--no-deps as applicable to the affected packages and targets, not as a mandatory suite.
Include --all-targets where supported when tests, examples, or benchmarks are affected;
plain cargo clippy does not cover every target. Check rustdoc examples when they
are part of the changed contract.

Build scripts and procedural macros execute code: assess trust before building an
untrusted change. In read-only review, prevent lockfile changes with --locked (or
--frozen when network access must also be disabled) where a lockfile exists, direct
build output outside the reviewed tree, and confirm git status is unchanged. If a
lockfile must be generated or other writes cannot be contained, run checks in a
disposable copy. Formatting writes, cargo fix, and cargo clippy --fix belong only
in authorized editing, not in the reviewed working tree.

Match supported feature combinations and target platforms. Do not assume
--all-features is valid or that default features cover a no_std consumer. Do not
enable clippy::pedantic, add -D warnings, or copy a lint preset unless the project
already requires it or the user requested a policy change. Honor MSRV when choosing
language features, dependencies, and lint attributes such as #[expect].

Use Miri for relevant unsafe invariants and fuzzing for untrusted parsers when the
risk warrants them and the tools are available; neither replaces a soundness
argument. Miri cannot execute most foreign calls, so it does not directly validate
most FFI integrations. Do not install a toolchain or build a new harness just to satisfy a generic
checklist. Reuse applicable verification results and report meaningful gaps through
the selected workflow instead of duplicating its checks or handback.
