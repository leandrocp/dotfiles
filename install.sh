#!/bin/sh

function link_root() {
  echo "$HOME links"

  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'config' ]; then
      rm -rf "$target"
      echo "ln -s "$PWD/$name" "$target""
      ln -s "$PWD/$name" "$target"
    fi
  done
}

function link_config() {
  echo "$HOME/.config links"

  for name in config/*; do
    target="$HOME/.$name"

    rm -rf "$target"
    echo "ln -s "$PWD/$name" "$target""
    ln -s "$PWD/$name" "$target"
  done
}

function bootstrap() {
  echo "bootstrap"

  echo "touch ~/.sensitive"
  touch ~/.sensitive

  echo "homebrew"
  [[ -f /opt/homebrew/bin/brew ]] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source apps_osx.sh

  echo "rtx"
  curl https://mise.jdx.dev/install.sh | sh
}

link_root
link_config
bootstrap
