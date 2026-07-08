## dotfiles

## Setup

1. Install [mise](https://mise.jdx.dev)

```sh
curl https://mise.run | sh
```

2. Bootstrap

```sh
~/.local/bin/mise exec git@latest -- git clone git@github.com:leandrocp/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
~/.local/bin/mise trust "$PWD/config/mise/config.toml"
MISE_JOBS=1 MISE_GLOBAL_CONFIG_FILE="$PWD/config/mise/config.toml" ~/.local/bin/mise bootstrap --yes --force-dotfiles
```
