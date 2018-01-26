#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

function install() {
  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'oh-my-zsh' ]; then
      rm -rf "$target"
      echo "ln -s "$PWD/$name" "$target""
      ln -s "$PWD/$name" "$target"
    fi
  done

  touch ~/.sensitive

  cp -R ~/.dotfiles/oh-my-zsh/custom ~/.oh-my-zsh/

  git clone https://github.com/tarjoilija/zgen.git ~/.zgen

  mkdir -p ~/.tmux/plugins
  mkdir -p ~/.tmux/themes
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  git clone https://github.com/seebi/tmux-colors-solarized.git ~/.tmux/themes/solarized

  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

install
