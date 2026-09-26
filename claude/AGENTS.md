# Global instructions

## General

- Run `date` to find out the current date, especially current year

## Shell commands

- Never wrap commands in `timeout`, `gtimeout`, `timeout -k`, or `perl`/`python` timeout shims by default — just run the command
- Use the tool's own timeout parameter when a limit is needed; don't reimplement it in the shell
- Only add an explicit `timeout` when a command is known to hang or block forever (e.g. watch/tail/serve/REPL), and prefer a non-interactive flag (`--no-pager`, `--watch=false`, `-n1`) over a timeout
- Don't pad commands with `sleep` to "wait for" something; poll for the actual condition or use the tool's blocking/background support

## Working relationship

- No sycophancy
- Be direct, matter-of-fact, and concise
- Be critical; challenge my reasoning
- Don’t include timeline estimates in plans

## Git and GitHub

- Use [Worktrunk](https://worktrunk.dev/) for all Git worktree lifecycle operations; never invoke `git worktree` directly
- Create or switch worktrees with `wt switch`, merge them with `wt merge`, and clean them up with `wt remove`
- Use the `gh` CLI (e.g. `gh repo view`, `gh api`, `gh search`, `gh pr/issue` commands), or
  clone the repo into a temp directory (e.g. `git clone <url> "$(mktemp -d)/repo"`) and explore it locally.
- Never EVER push changes, close issues, add comments to GitHub without my confirmation
- When I authorize a push, create a topic branch, push it, and open a PR by default
- Never push directly to a repository's default branch unless I explicitly say `push to main` or name that branch
- General instructions such as `push`, `ship`, `publish`, or `do it and push` do not authorize a default-branch push
- Treat branch tracking as part of push safety: `git checkout -b <topic> origin/<default>` can make the topic branch track the remote default branch, and with `push.default=upstream` even `git push origin <topic>` can update the default branch
- Create topic branches from a remote default branch with `git switch --no-track -c <topic> origin/<default>` (or `git checkout --no-track -b <topic> origin/<default>`)
- Before pushing, verify the topic branch does not track the remote default branch; if it does, run `git branch --unset-upstream`
- Push topic branches with `git push -u origin HEAD` or an explicit `<source>:<destination>` refspec
- NEVER add Co-Authored-By trailers to commit messages
