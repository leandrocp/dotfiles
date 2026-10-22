---
name: lp-plan
description: "Produces a code-grounded feature or change plan with acceptance criteria, implementation slices, risks, and verification. Use when asked to plan or design work before implementation, including revising an existing plan."
license: MIT
---

# Plan

Resolve the decisions needed to implement the requested outcome, and define how
to verify it. Planning alone does not authorize implementation.

## Ground the plan

1. Read the request, existing plan or issue including relevant comments, and
   applicable repository guidance. Reuse decisions already made in the conversation.
2. Inspect the code that owns the behavior, its callers and contracts, existing
   tests, and the repository's build and check commands. Distinguish observations
   from assumptions. Do not invent files, APIs, or available infrastructure.
3. Identify the user or caller, intended outcome, non-goals, and behavior that
   must remain unchanged. For an issue, check whether the requested behavior
   already exists or the reported defect is already fixed.
4. Resolve factual questions through inspection. Ask about product choices only
   when they materially affect scope, compatibility, risk, or acceptance and the
   user has not delegated them. Offer a recommendation with its tradeoff. Group
   independent questions; defer questions that depend on unanswered ones.

Use a short inline plan for a clear local change. Use the project's existing plan
format and location for substantial or multi-session work. Do not create tracker
items, duplicate an existing spec system, or overwrite another unfinished plan.
Save a new document when requested or needed for an agreed persistent handoff.

## Define behavior before structure

Write concrete, numbered acceptance criteria from the consumer's perspective.
Cover the happy path, meaningful failure states, boundaries, and invariants that
must not regress. Include permissions, cancellation, concurrency, accessibility,
or compatibility only where relevant. A criterion must be observable, not an
adjective such as "robust" or "clean."

Keep product intent separate from the implementation approach, even when both fit
in one short document. Reuse supplied design references rather than guessing UI
intent. Mark unresolved requirements explicitly instead of silently choosing them.

For a consequential architectural choice:

- Sketch a caller's usage and the contract it needs before proposing internal layers.
- Identify the owning modules, data flow, and relevant types or interfaces.
- Compare genuinely different viable approaches when the tradeoff is unresolved.
  Prefer the smallest design that fits current requirements and repository patterns.
- Name the assumption that could invalidate the recommendation and how to test it.
  Propose a bounded experiment if reading cannot settle it. Do not write prototype
  code during a planning-only request without authorization.

## Slice and verify

Break substantial work into dependency-ordered slices that each deliver a narrow,
testable path through the system. Put the highest-risk uncertainty early.

For each slice, record:

- The behavior it delivers and the acceptance criteria it satisfies.
- The likely owning modules or files, based on inspected code.
- Actual blocking dependencies, not merely a preferred execution order.
- The verification method and expected result, using existing test boundaries.

Do not force vertical slicing onto a mechanical cross-repository migration. Use
expand, migrate, contract when compatibility requires it, and identify the final
integration check. Separate behavior-preserving refactoring from behavior changes.

Parallel work is optional. Propose it only for independent ownership or a concrete
context-isolation benefit. State shared contracts and integration responsibility;
do not assign concurrent edits to the same files. Defer model and worktree choices
to the user's harness and repository rules.

Choose verification by failure mode, not fixed file counts or coverage quotas.
Map important acceptance criteria to tests, runtime scenarios, or measurements.
Identify environment blockers. Include rollback and error detection for changes
where deployment or data compatibility creates real risk.

## Deliver the handoff

Return the goal and non-goals, grounded approach, ordered slices, decisions and
remaining questions, verification plan, and material risks. Link existing sources
instead of restating them. Pin important code references to the inspected revision
when the plan must survive changes to the codebase.

The plan is ready when implementation can start without guessing about material
requirements, dependencies, or what counts as done. Label unresolved blockers.
Stop after a planning-only request. For an explicit chain, continue only with the
stages the user named, in their requested order; do not skip a requested review to
start implementation. If called by `lp-build` during an authorized implementation
task, return the actionable plan to that caller without adding an approval gate.
Use the host's skill loader or read `../<skill-name>/SKILL.md` relative to this
skill directory, such as `../lp-build/SKILL.md` or `../lp-code-review/SKILL.md`.

On a later handoff, carry the plan, decisions, current state, and evidence gaps
forward. Recheck stale code assumptions instead of repeating settled questions.
Neither a plan nor a handoff grants permission to publish, merge, or deploy.
