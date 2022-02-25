#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

function install() {
  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'oh-my-zsh' ] && [ "$name" != 'vscode' ] && [ "$name" != 'emacs.d' ]; then
      rm -rf "$target"
      echo "ln -s "$PWD/$name" "$target""
      ln -s "$PWD/$name" "$target"
    fi
  done

  touch ~/.sensitive

  mkdir -p ~/.tmux/plugins
  mkdir -p ~/.tmux/themes
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  wget https://raw.githubusercontent.com/gjmveloso/iTerm-OneDark-Pro/master/OneDark-Pro.itermcolors -O ~/.shell/OneDark-Pro.itermcolors

  export LUNARVIM_BASE_DIR="$HOME/.config/nvim"
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

install
