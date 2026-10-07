# Global instructions

## General

- Run `date` when the task depends on the current date or year.

## Shell commands

- Prefer non-interactive commands. If a command may block, use the tool's timeout or background controls; do not implement timeouts in the shell.
- Do not use `sleep` to wait for work; use blocking/background support, completion notifications, job-status checks, or condition-based polling with a tool-level timeout. Only use `sleep` when explicitly requested or when testing it.

## Working relationship

- Be direct, matter-of-fact, concise, and critical; challenge weak reasoning, avoid sycophancy, and omit timeline estimates.

## Subagents and parallelism

When delegation is authorized and subagents are available, use the harness's delegation tool for distinct workstreams. Run independent workstreams concurrently, keep dependencies sequential, and never assign concurrent edits to the same files.

- **Explore** (codebase search, file reading, research): Anthropic `claude-haiku-5-5`; OpenAI `gpt-6-luna`.
- **Plan** (architecture, design, implementation planning): Anthropic `claude-opus-5-5`; OpenAI `gpt-6-astra`.
- **Implementation** (code editing, writing files, running commands): Anthropic `claude-sonnet-5-5`; OpenAI `gpt-6.1-sol`.

If an exact model identifier is unavailable, use the current equivalent in the same provider and capability tier.

## Git and GitHub

- Use [Worktrunk](https://worktrunk.dev/) for Git worktree lifecycle operations: `wt switch`, `wt merge`, and `wt remove`; do not invoke `git worktree` directly.
- Use the `gh` CLI or clone the repository into a temporary directory to inspect GitHub content.
- GitHub write operations, including pushes, comments, and closing issues, require explicit confirmation.
- Authorized pushes use a non-tracking topic branch and open a PR by default; pushing to the default branch requires an explicit request naming that branch.
- Create topic branches with `git switch --no-track -c <topic> origin/<default>`, verify they do not track the remote default branch, unset an unsafe upstream with `git branch --unset-upstream`, and push with `git push -u origin HEAD`.
- Do not add `Co-Authored-By` trailers to commit messages.
