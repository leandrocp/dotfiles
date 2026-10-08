# Global instructions

## General

- Run `date` when the task depends on the current date or year.

## Shell commands

- Prefer non-interactive commands. If a command may block, use the tool's timeout or background controls; do not implement timeouts in the shell.
- Do not use `sleep` to wait for work; use blocking/background support, completion notifications, job-status checks, or condition-based polling with a tool-level timeout. Only use `sleep` when explicitly requested or when testing it.

## Working relationship

- Be direct, matter-of-fact, concise, and critical; challenge weak reasoning, avoid sycophancy, and omit timeline estimates.
- Do not repeat what a diff or tool output already shows.

## Subagents and parallelism

When delegation is authorized and subagents are available, use the harness's delegation tool for distinct workstreams. Run independent workstreams concurrently, keep dependencies sequential, and never assign concurrent edits to the same files.

- **Explore** (codebase search, file reading, research): Anthropic `claude-haiku-5-5`; OpenAI `gpt-6-luna`.
- **Plan** (architecture, design, implementation planning): Anthropic `claude-opus-5-5`; OpenAI `gpt-6-astra`.
- **Implementation** (code editing, writing files, running commands): Anthropic `claude-sonnet-5-5`; OpenAI `gpt-6.1-sol`.

If an exact model identifier is unavailable, use the current equivalent in the same provider and capability tier.

Set the model on every subagent call; do not let it inherit the main model. Do not use a subagent when one or two direct tool calls will do.

## Git and GitHub

- Use [Worktrunk](https://worktrunk.dev/) for Git worktree lifecycle operations: `wt switch`, `wt merge`, and `wt remove`; do not invoke `git worktree` directly.
- Use the `gh` CLI or clone the repository into a temporary directory to inspect GitHub content.
- GitHub write operations, including pushes, comments, and closing issues, require explicit confirmation.
- Authorized pushes use a non-tracking topic branch and open a PR by default; pushing to the default branch requires an explicit request naming that branch.
- Create topic branches with `git switch --no-track -c <topic> origin/<default>`, verify they do not track the remote default branch, unset an unsafe upstream with `git branch --unset-upstream`, and push with `git push -u origin HEAD`.
- Do not add `Co-Authored-By` trailers to commit messages.

## Tool use

- Use grep or read a line range to find code before reading a whole large file.
- Send independent tool calls together in one turn.
- Do not re-read a file right after editing it; the edit tool already confirms the change.
- Do not repeat a check that a tool call already confirmed.
