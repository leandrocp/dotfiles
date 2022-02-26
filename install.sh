#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

function install() {
  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'lvim.config.lua' ]; then
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
  ln -s $HOME/.dotfiles/lvim.config.lua $HOME/.config/nvim/config.lua
}

install
