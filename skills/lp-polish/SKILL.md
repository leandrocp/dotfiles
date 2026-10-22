---
name: lp-polish
description: "Simplifies a scoped change and strengthens tests, linting, and verification while preserving intended behavior. Use when asked to clean up or unslop code, improve test quality, or perform a final quality pass, not for a read-only review."
license: MIT
---

# Polish

Improve clarity and confidence without changing the intended behavior or expanding
the task. This is a scoped editing pass, not an architectural rewrite.

## Establish the baseline

Identify the requested diff or module, applicable repository guidance, and existing
acceptance criteria. Default to the current change, not the whole repository.
Preserve other people's edits and clarify ownership before changing unrelated work.

Read the code, callers, tests, and relevant history until the contract is clear.
Understand outputs, errors, side effects, ordering, compatibility, and any measured
performance constraints before calling something redundant.

Discover the existing formatter, linter, type checker, and test commands from the
repository. Use prior results only if they still apply to the current code and
environment. Establish relevant baseline checks before structural edits; distinguish
existing failures from regressions. Missing infrastructure is a limitation, not a
reason to install a new stack or fabricate a passing result.

## Remove complexity that earns no value

Look for specific opportunities in the scoped code:

- Pass-through wrappers and abstractions without an independent responsibility.
- Dead code, debug output, unused options, and speculative extension points.
- Duplicate policy that already has a canonical owner or helper.
- Scattered branches that a clearer existing data model can eliminate.
- Casts, optionality, and fallbacks hiding a contract that can be expressed directly.
- Names that conceal behavior, and comments that repeat code or misstate reality.

Prefer deletion or a direct expression over moving the same complexity into more
files. Keep useful abstractions, validation at trust boundaries, compatibility for
real consumers, and comments explaining non-obvious constraints. Check consumers
before deleting an apparently unused path; a text search is not proof against
dynamic registration or external callers.

Do not optimize for line count, enforce arbitrary function sizes, introduce new
patterns merely for taste, or remove error handling because it looks verbose.
Use the project's formatter for mechanical formatting.

For touched prose, remove filler, unsupported claims, and repetitive framing while
preserving meaning and useful technical vocabulary. Do not impose punctuation bans
or rewrite unrelated documentation to match a personal voice.

## Strengthen evidence, not test volume

Inspect tests for behavior users or callers rely on. Prefer public boundaries and
real implementations, with test doubles at uncontrollable external boundaries.
Expected values must come from the contract, a worked example, or an independent
reference, not a duplicate of the code's algorithm.

Identify a plausible wrong implementation, then choose an input that distinguishes
it from the required behavior. Prioritize missing boundaries, denied paths, ordering,
and asymmetric cases over more happy-path examples. Extend an existing test before
creating a new test file. Keep tests that would catch meaningful regressions and
survive internal refactoring; use temporary probes for one-off validation.

Behavior-preserving refactoring should pass existing tests unchanged. If coverage
is inadequate, establish a focused characterization check before moving structure.
Do not change assertions to accommodate a behavioral difference introduced by
cleanup. If a real bug is discovered, report it separately; fix it via `lp-build` only
when the user's scope authorizes that behavior change.

Inspect the diff for weakened checks: new suppressions, skipped or deleted tests,
removed assertions, lowered thresholds, and unfinished stubs. Investigate legitimate
exceptions; do not ban them blindly or add arbitrary coverage quotas. Reuse existing
quality gates rather than creating a second source of truth for commands and policy.

## Verify and finish

Make coherent, behavior-preserving edits and run affected checks between meaningful
steps. At the end run applicable formatting, linting, types, tests, and integration
checks proportionate to the blast radius. For UI or interaction changes, exercise
representative states and inspect the rendered evidence using available tooling.
Do not rerun unchanged checks for reassurance; rerun when relevant code, inputs,
dependencies, or the environment changed.

Compare the result with the baseline. Keep a simplification only if it reduces
reader effort without changing the contract. Back out only your unsuccessful edits,
preserving pre-existing work. Remove temporary validation files and instrumentation.

Report the meaningful quality improvement, executed checks and results, remaining
gaps, and actual delivery state. No change is a valid outcome when the code already
meets the bar. For a chain, continue only with the named stages in the requested
order. Hand the next stage the final diff, contract, decisions, and current evidence.
Use the host's skill loader or read `../<skill-name>/SKILL.md` relative to this skill
directory, such as `../lp-code-review/SKILL.md` or `../lp-build/SKILL.md`. Do not
auto-publish, push, merge, or turn cleanup into an endless loop.
