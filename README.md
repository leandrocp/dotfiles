# dotfiles

## Setup

1. Install [mise](https://mise.jdx.dev)

```sh
curl https://mise.run | sh
```

1. Bootstrap

```sh
~/.local/bin/mise exec git@latest -- git clone git@github.com:leandrocp/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
~/.local/bin/mise trust "$PWD/config/mise/config.toml"
MISE_JOBS=1 MISE_GLOBAL_CONFIG_FILE="$PWD/config/mise/config.toml" ~/.local/bin/mise bootstrap --yes --force-dotfiles
```

1. In Tinycast, open **Settings → Backup → Import** and select
   `~/.dotfiles/config/tinycast/settings.json`.

## Moshi

Bootstrap installs `moshi-hook`. Enable macOS **Remote Login**, install Moshi on
the phone, and pair over WireGuard:

```sh
moshi-hook host setup
```

Moshi detects Herdr automatically. To enable agent notifications:

```sh
moshi-hook pair --token <token-from-Moshi>
moshi-hook install
brew services start moshi-hook
```
