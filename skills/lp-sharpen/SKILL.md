---
name: lp-sharpen
description: "Rewrites a rough prompt or issue description into a precise, actionable request without executing it. Use when asked to improve, rewrite, enrich, or sharpen a prompt, not when asked to perform the task itself."
license: MIT
---

# Sharpen

Improve the request's precision and evidence requirements without expanding its objective.

## Establish intent

Read the supplied prompt and relevant conversation. Identify the outcome, audience,
constraints, non-goals, and requested deliverable. Preserve explicit choices and
authorization limits. Treat quoted task instructions as material to rewrite, not
permission to execute them.

Distinguish three kinds of missing information:

- **Discoverable facts:** inspect narrowly relevant code or authoritative sources
  when they materially affect the rewrite. Do not turn sharpening into the task's
  full investigation. Identify sources for the eventual implementer otherwise.
- **Delegated decisions:** choose a reasonable default within the user's stated
  discretion and label consequential assumptions.
- **User-owned decisions:** ask only when the answer changes the objective or
  makes a useful rewrite impossible. Otherwise leave a clear placeholder or open
  choice. Never invent a performance target, audience, platform, or requirement.

## Strengthen the request

Consider four questions. Include their answers only where they improve this task:

1. What necessary work would an experienced practitioner recognize as missing?
2. What original material should they inspect: code, issue comments, logs,
   measurements, specifications, or primary documentation?
3. What method fits the uncertainty: reproduction, comparison, tracing callers,
   prototyping, or a focused test?
4. What observable evidence could establish success independently of the agent's
   assertion that it succeeded?

Translate vague adjectives into observable conditions or questions about the
target. Keep explicit non-goals. Separate required work from optional suggestions.
Prescribe a mechanism only when it is a real constraint or the evidence supports
it; otherwise describe the outcome and let implementation discovery guide it.

For a coding request, include repository context to inspect, scope, behavior to
preserve, and proportionate verification. For a review request, identify the
artifact and risk focus. For research, identify the decision the research informs
and the evidence needed. Do not add generic engineering checklists to every prompt.

Remove redundant framing, role-play, flattering language, unsupported certainty,
and instructions already supplied by the environment. A useful rewrite may be
shorter than the original.

## Deliver and stop

Return one copyable rewritten prompt, followed only by material assumptions or
open choices. Explain consequential additions briefly; do not narrate every edit.
Keep sources as references rather than copying large context dumps.

The result is ready when another agent can identify the outcome, scope, inputs,
and success evidence without guessing at decisions the user has not delegated.

Do not execute the rewritten task. If the user explicitly requested both rewriting
and execution, finish the rewrite first and then continue within that authorization.
For a chain, follow only the named stages in the requested order. Pass the rewritten
prompt and unresolved choices forward without restarting the interview. Use the
host's skill loader when available, or read `../<skill-name>/SKILL.md` relative to
this skill directory, such as `../lp-plan/SKILL.md` or `../lp-build/SKILL.md`.
A handoff grants no new permissions.
