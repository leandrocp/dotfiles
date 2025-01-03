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

  echo "homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source apps_osx.sh

  echo "mise"
  curl https://mise.run | sh
  mise install

  echo "fsh theme"
  fast-theme XDG:catppuccin-frappe
}

function zellij() {
  curl -s https://api.github.com/repos/fresh2dev/zellij-autolock/releases/latest | jq -r '.assets[].browser_download_url' |  wget -i - -P ~/.config/zellij/plugins/
  curl -s https://api.github.com/repos/dj95/zjstatus/releases/latest | jq -r '.assets[].browser_download_url' |  wget -i - -P ~/.config/zellij/plugins/
  curl -s https://api.github.com/repos/karimould/zellij-forgot/releases/latest | jq -r '.assets[].browser_download_url' |  wget -i - -P ~/.config/zellij/plugins/
}

link_root
link_config
bootstrap
