---
name: lp-build
description: "Implements an approved plan, fixes a specified issue, or makes an ad-hoc code change with proportionate verification. Use when asked to implement, fix, or change behavior, not for planning-only, review-only, or explanation requests."
license: MIT
---

# Build

Deliver the requested change and evidence that it works. A formal plan is optional.

## Establish the contract

Read the request, applicable guidance, relevant code and tests, and any supplied
plan, issue, or review findings. Read issue comments before treating the original
report as current. Check whether the work is already implemented or superseded.

Identify the intended behavior, non-goals, affected public contracts, and checks
that define success. Preserve unrelated worktree changes. Use repository commands
and existing patterns; do not introduce a new framework to perform a small task.

Reuse an existing plan without treating it as infallible. Recheck stale assumptions.
For a small request, establish the local contract and proceed. For a substantial
request with unresolved design, use `lp-plan` through the host's skill loader or
read `../lp-plan/SKILL.md` relative to this skill directory. Resume implementation
within the original authorization once actionable; ask only about consequential
choices not delegated to you.

## Select the execution path

### Feature or planned change

Implement the smallest end-to-end slice that makes meaningful behavior verifiable.
Run focused checks before depending on that slice in later work. Follow real
dependencies rather than implementing all of one layer before testing integration.
Keep a persistent plan's progress and implementation decisions current when one
exists. Record material deviations; do not weaken acceptance criteria to fit code.

### Bug or open issue

1. Separate the reporter's observations from their proposed diagnosis. Identify
   the expected behavior, actual symptom, version, and relevant environment.
2. Build the cheapest reliable reproduction that exercises the reported path.
   Run it before changing production code and confirm it fails for the intended
   reason. A nearby error or a test that only checks for crashes is not the repro.
3. Reduce the scenario without losing the symptom. Form competing, falsifiable
   hypotheses when the cause is uncertain. Use focused instrumentation or a
   debugger to distinguish them; change one variable at a time.
4. Fix the cause at the owning boundary. Remove speculative fixes whose motivating
   hypothesis was disproved. Avoid fallbacks or retries that conceal broken contracts.
5. Rerun the original scenario, not only the reduced test, and relevant nearby checks.
   Remove temporary instrumentation and scratch files.

Prefer a failing regression test at an existing public boundary before the fix.
If a durable test is impractical, use an executable script, browser scenario, or
other direct check. State missing before evidence or environment limitations;
never turn non-reproduction into a claim that the bug is fixed. Investigate as far
as available evidence allows and report a blocker rather than inventing certainty.

### Ad-hoc or mechanical change

Make the smallest coherent edit that satisfies the request. Scale checks to the
contract and risk: configuration validation for config, unchanged tests for a
refactor, and runtime behavior for an interaction change. Do not create a spec,
task graph, or new test harness for an obvious local edit.

## Maintain quality during implementation

- Test observable behavior through public interfaces. Derive expected values from
  the contract or worked examples, not from the implementation under test.
- Choose inputs where a plausible wrong implementation gives a different result.
  Exercise relevant boundaries, denied actions, and asymmetric cases.
- For testable new behavior, prefer a focused failing test followed by the minimal
  implementation. Keep regression tests that catch meaningful future failures.
  Temporary validation need not become a permanent test.
- Separate structural refactoring from changed behavior and verify each stage.
  Avoid speculative abstractions, unrelated cleanup, and internal-mock assertions.
- When a check fails, diagnose the failure before building further on that result.
  Distinguish pre-existing failures from regressions. Never suppress checks, remove
  assertions, or relax quality thresholds merely to obtain a pass.
- Delegate only when it provides independent ownership or useful isolation. Follow
  the host and repository rules for tools, models, worktrees, and integration.

## Verify and report

Inspect the final diff for scope, missed callers, unfinished code, and accidental
changes. Run applicable formatting, linting, type checks, and tests. Use focused
checks during iteration and broader integration or suite checks when the blast
radius warrants them. Reuse results only while their code, inputs, dependencies,
and environment remain applicable.

Exercise changed UI or runtime behavior on the matching surface. Inspect captured
visual evidence; a screenshot alone does not establish an interaction works.
For performance claims, compare measured equivalent scenarios, not estimates.

Report the outcome, commands and decisive results, unresolved criteria or risks,
and actual delivery state: local edits, committed, pushed, merged, or deployed.
Do not imply a step occurred because a previous agent reported success.

If the user requested a chain, continue only with the skills they named, in the
requested order. Pass the resulting change, contract, decisions, and evidence to
the next stage. Load it through the host or read `../<skill-name>/SKILL.md` relative
to this skill directory. For example, `lp-build` then `lp-code-review` does not include
`lp-polish`. Otherwise stop after implementation and its own verification; extra
skills are not mandatory gates. Review findings can return to `lp-build` as scoped
fixes, retaining the original contract and stable finding identifiers.
Publishing, closing issues, pushing, merging, and deployment require the user's
authorization under the applicable rules; invoking this skill grants none of them.
