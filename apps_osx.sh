#!/usr/bin/env bash

# https://github.com/Homebrew/install

function brew_install() {
  if brew ls --versions "$1"; then brew upgrade "$1"; else brew install "$1"; fi
}

brew update

packages=(\
autoconf \
automake \
bat \
btop \
cmake \
cmark-gfm \
coreutils \
dust \
exa \
fd \
fzf \
gcc \
gh \
gnu-sed \
lazygit \
openssl \
pgcli \
renameutils \
ripgrep \
slack \
starship \
wxwidgets \
zoxide \
zsh \
)

for i in "${packages[@]}"
do
  brew_install "$i"
done

brew tap homebrew/cask-fonts
brew install --force --cask font-hack-nerd-font

$(brew --prefix)/opt/fzf/install

brew cleanup
