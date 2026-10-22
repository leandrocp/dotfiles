# Workflow skills

`lp-sharpen` improves a prompt, `lp-plan` designs the change, `lp-build` implements
or fixes it, `lp-polish` simplifies and checks it, and `lp-review` challenges it
without editing. Use each independently or name a chain in order. The `lp-` prefix
avoids common built-in names; these skills can also load automatically for matching tasks.

This directory is shared through `~/.agents/skills` and `~/.claude/skills` symlinks.
Ask "use the lp-review skill"; Claude Code supports `/lp-review`, Pi
`/skill:lp-review`. Reload skills or start a new session after changes. Third-party
installs here are gitignored; `git clean -x` still deletes ignored files. Local
links do not install skills into cloud sessions.

Adapted from [Warp common-skills](https://github.com/warpdotdev/common-skills/tree/8792394ff1b655e0af451b8fabb68ef0cfcbd208/.agents/skills),
[Matt Pocock's skills](https://github.com/mattpocock/skills/tree/5beb35b040e3de97e54fa9e386d7e42d15c295c2/skills),
[pstack](https://github.com/cursor/plugins/tree/699e1e7488c53c05ca13409f40da83cd37682091/pstack/skills),
and [Addy Osmani's agent-skills](https://github.com/addyosmani/agent-skills/tree/aeac41d4d005999432bb7312f7ff06383a91d59d/skills).
These are reference sources, not runtime dependencies. See [LICENSE](LICENSE).
