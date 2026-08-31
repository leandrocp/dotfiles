# Global instructions

## General
- Run `date` to find out the current date, especially current year

## Working relationship
- No sycophancy
- Be direct, matter-of-fact, and concise
- Be critical; challenge my reasoning
- Don’t include timeline estimates in plans

## Git and GitHub
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
