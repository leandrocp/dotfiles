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

## Language companions

`lp-rust` supplies Rust-specific guidance without replacing the workflow skills.
`lp-plan`, `lp-build`, `lp-polish`, and `lp-code-review` conditionally load it when
the scoped task substantively involves Rust source or Rust-specific Cargo
configuration, not merely because a repository contains Rust. In mixed-language
projects, it applies only to the Rust portion. If unavailable, they continue with
repository guidance without installing it. You can also invoke it explicitly:

- "Use lp-build with lp-rust to fix this parser."
- "Use lp-code-review with lp-rust to review the Rust changes in this PR."

The description is available for discovery; the body loads on use, and topic
references are read only when relevant.
It does not automatically start workflow stages, install tools, or adopt a lint
preset. Workflow skills remain language-neutral.

## Installation and sources

This directory is shared through `~/.agents/skills` and `~/.claude/skills` symlinks.
Ask "use the lp-code-review skill"; Claude Code supports `/lp-code-review`, Pi
`/skill:lp-code-review`. Reload skills or start a new session after changes. Third-party
installs here are gitignored; `git clean -x` still deletes ignored files. Local
links do not install skills into cloud sessions.

Adapted from [Warp common-skills](https://github.com/warpdotdev/common-skills/tree/8792394ff1b655e0af451b8fabb68ef0cfcbd208/.agents/skills),
[Matt Pocock's skills](https://github.com/mattpocock/skills/tree/5beb35b040e3de97e54fa9e386d7e42d15c295c2/skills),
[pstack](https://github.com/cursor/plugins/tree/699e1e7488c53c05ca13409f40da83cd37682091/pstack/skills),
and [Addy Osmani's agent-skills](https://github.com/addyosmani/agent-skills/tree/aeac41d4d005999432bb7312f7ff06383a91d59d/skills).
The `lp-rust` companion and its curated topic summaries are adapted from
[Morgan Linton's BeautifulRust](https://github.com/morganlinton/BeautifulRust/tree/2b2d53a66f6f36ab4b8d6a93070183d91e77fad4),
not a wholesale copy of its skills, upstream source digests, or lint configuration.
These are reference sources, not runtime dependencies. See [LICENSE](LICENSE).

BeautifulRust cites the Google Rust Style Guide (CC BY 3.0), Rust API Guidelines
(MIT or Apache-2.0), Effective Rust's online edition (CC BY-NC-ND 4.0), Rust Design
Patterns (MPL-2.0), and Microsoft Pragmatic Rust Guidelines (MIT). The companion
links to those originals; it does not vendor their text or relicense those works.
