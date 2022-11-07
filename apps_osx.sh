#!/usr/bin/env bash

brew update
brew upgrade

brew install \
coreutils \
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
zsh

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

brew cleanup
