#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

function install() {
  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'oh-my-zsh' ]; then
      rm -rf "$target"
      if [[ "$OSTYPE" == "cygwin" ]]; then
        echo "cp -R "$PWD/$name" "$target""
        cp -R "$PWD/$name" "$target"
      else
        echo "ln -s "$PWD/$name" "$target""
        ln -s "$PWD/$name" "$target"
      fi
    fi
  done

  touch ~/.sensitive

  cp -R ~/.dotfiles/oh-my-zsh/custom ~/.oh-my-zsh/

  git clone https://github.com/zsh-users/antigen.git ~/.antigen-zsh

  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

  git clone https://github.com/powerline/fonts.git ~/.powerline-fonts
  bash ~/.powerline-fonts/install.sh

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  mkdir ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update

  git clone https://github.com/creationix/nvm.git ~/.nvm

  git clone https://github.com/gcuisinier/jenv.git ~/.jenv
}

install
