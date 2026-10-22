# Workflow skills

The `lp-` prefix avoids common built-in names. Skills can load automatically for
matching tasks, or be called explicitly:

- **Sharpen:** "Use lp-sharpen to rewrite this prompt: make the dashboard faster."
- **Plan:** "Use lp-plan to design scheduled exports. Don't implement yet."
- **Build:** "Use lp-build to fix issue #123 and verify the original bug is gone."
- **Polish:** "Use lp-polish on the current diff: simplify it and strengthen tests without changing behavior."
- **Review:** "Use lp-code-review on PR #123, focusing on retries and tenant isolation. Report findings without edits."
- **Open PR:** "Use lp-open-pr to publish the current change as a PR against main and get CI green."
- **Chain:** "Use lp-build to implement the approved plan, then lp-polish, then lp-code-review. Stop with the review findings."

This directory is shared through `~/.agents/skills` and `~/.claude/skills` symlinks.
Ask "use the lp-code-review skill"; Claude Code supports `/lp-code-review`, Pi
`/skill:lp-code-review`. Reload skills or start a new session after changes. Third-party
installs here are gitignored; `git clean -x` still deletes ignored files. Local
links do not install skills into cloud sessions.

Adapted from [Warp common-skills](https://github.com/warpdotdev/common-skills/tree/8792394ff1b655e0af451b8fabb68ef0cfcbd208/.agents/skills),
[Matt Pocock's skills](https://github.com/mattpocock/skills/tree/5beb35b040e3de97e54fa9e386d7e42d15c295c2/skills),
[pstack](https://github.com/cursor/plugins/tree/699e1e7488c53c05ca13409f40da83cd37682091/pstack/skills),
and [Addy Osmani's agent-skills](https://github.com/addyosmani/agent-skills/tree/aeac41d4d005999432bb7312f7ff06383a91d59d/skills).
These are reference sources, not runtime dependencies. See [LICENSE](LICENSE).
