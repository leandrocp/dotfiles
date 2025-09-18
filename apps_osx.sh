#!/usr/bin/env bash

# https://github.com/Homebrew/install

# https://passepartoutvpn.app
# https://zed.dev/releases/preview
# https://postgresapp.com

brew update
brew tap homebrew/cask-fonts

packages=(
  1password
  ast-grep
  autoconf
  automake
  bat
  btop
  cmake
  cmark-gfm
  coreutils
  dash
  devutils
  discord
  dust
  eza
  fd
  font-hack-nerd-font
  fzf
  gcc
  gh
  git
  gnu-sed
  lazygit
  macdown
  muzzle
  obsidian
  openssl
  pgcli
  proton-mail
  protonmail-bridge
  raycast
  renameutils
  ripgrep
  slack
  tableplus
  typos-cli
  wxwidgets
  zoxide
  zsh
)

for i in "${packages[@]}"; do
  brew install "$i"
done

brew install --cask dash

$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

brew cleanup
