# Global instructions

## Investigating GitHub repos
When investigating a GitHub repository, do not browse via web fetches. Instead either:
- use the `gh` CLI (e.g. `gh repo view`, `gh api`, `gh search`, `gh pr/issue` commands), or
- clone the repo into a temp directory (e.g. `git clone <url> "$(mktemp -d)/repo"`) and explore it locally.
