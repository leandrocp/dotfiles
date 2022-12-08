#!/usr/bin/env bash

brew update
brew upgrade

brew install \
coreutils \
autoconf \
moreutils \
findutils \
gnu-sed \
wget \
ack \
git \
tree \
htop-osx \
ack \
fzf \
ripgrep \
openssh \
ssh-copy-id \
awscli \
jq \
pgcli \
bat \
zplug \
renameutils \
dust \
aspell \
fzy \
fd \
dog \
efm-langserver \
pandoc \
autojump \
vlc \
lazygit \
fasd \
zsh \
kitty \
lua \
rust \
starship \
exa \
muzzle \
slack \
maccy \
rectangle \
macdown

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

brew cleanup
