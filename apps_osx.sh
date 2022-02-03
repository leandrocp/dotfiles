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
editorconfig \
tmux \
openssh \
ssh-copy-id \
awscli \
jq \
pgcli \
bat \
hub \
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
vlc

brew cleanup
