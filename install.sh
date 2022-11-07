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

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  wget https://raw.githubusercontent.com/gjmveloso/iTerm-OneDark-Pro/master/OneDark-Pro.itermcolors -O ~/.shell/OneDark-Pro.itermcolors

  asdf plugin add neovim
  asdf install neovim nightly

  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

install
