default:
    @just --list

all: link-root link-config homebrew apps-osx apps-mise apps-npm

update:
    #!/usr/bin/env zsh
    source ~/.shell/zinit
    brew upgrade
    brew cleanup
    zinit self-update
    zinit update
    mise plugins up
    mise up
    nvim --headless -c "lua vim.pack.update(nil, { force = true })" -c "quit"
    just apps-npm

link-root:
    #!/usr/bin/env bash
    for name in *; do
        case "$name" in
            justfile|README.md|shell|config|.git) continue ;;
        esac
        target="$HOME/.$name"
        echo "$target"
        rm -rf "$target"
        ln -s "$PWD/$name" "$target"
    done

link-config:
    #!/usr/bin/env bash
    for name in config/*; do
        target="$HOME/.$name"
        echo "$target"
        rm -rf "$target"
        ln -s "$PWD/$name" "$target"
    done

homebrew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"

apps-osx:
    brew update
    brew bundle install --file=Brewfile
    $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
    brew cleanup

apps-mise:
    mise plugins install neovim
    mise install

apps-npm:
    npm install -g @fsouza/prettierd
    npm install -g @openai/codex@latest
    npm install -g @github/copilot-language-server

check:
    #!/usr/bin/env bash
    echo "Checking dotfiles installation..."
    echo ""
    echo "Binaries:"
    binaries=(nvim zsh git fzf zoxide eza bat fd rg lazygit mise)
    for bin in "${binaries[@]}"; do
        if command -v "$bin" &> /dev/null; then
            echo "  ✓ $bin"
        else
            echo "  ✗ $bin"
        fi
    done

    echo ""
    echo "Git:"
    git config --global user.name &> /dev/null && echo "  ✓ user.name: $(git config --global user.name)" || echo "  ✗ user.name"
    git config --global user.email &> /dev/null && echo "  ✓ user.email: $(git config --global user.email)" || echo "  ✗ user.email"

    echo ""
    echo "Checking Homebrew env..."
    brew doctor
