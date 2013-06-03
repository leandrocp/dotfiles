#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "\033[0;33mHey! You're not running ZSH and OH-MY-ZSH.\033[0m See: https://github.com/robbyrussell/oh-my-zsh"
  exit
fi

function install() {
  for name in *; do
    target="$HOME/.$name"
    
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ]; then
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
}

read -p "This action will replace all target files. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  install
fi
