#!/usr/bin/env bash

# https://github.com/Homebrew/install

function brew_install() {
  if brew ls --versions "$1"; then brew upgrade "$1"; else brew install "$1"; fi
}

brew update

packages=(\
autoconf openssl coreutils automake renameutils dust fd dog autojump openjdk wxwidgets \
lazygit fasd gh libxslt fop z ripgrep zsh kitty lua rust starship exa \
muzzle slack maccy rectangle joplin pgcli \
)

for i in "${packages[@]}"
do
  brew_install "$i"
done

brew tap homebrew/cask-fonts
brew install --force --cask font-hack-nerd-font

brew cleanup
