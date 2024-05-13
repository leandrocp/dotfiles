#!/usr/bin/env bash

# https://github.com/Homebrew/install

# https://passepartoutvpn.app
# https://zed.dev/releases/preview
# https://postgresapp.com

brew update
brew tap homebrew/cask-fonts

packages=(\
1password \
autoconf \
automake \
bat \
btop \
cmake \
cmark-gfm \
coreutils \
dash \
devutils \
discord \
docker \
dust \
exa \
fd \
font-hack-nerd-font \
fzf \
gcc \
gh \
gnu-sed \
lazygit \
macdown \
muzzle \
obsidian \
openssl \
pgcli \
proton-mail \
protonmail-bridge \
raycast \
renameutils \
ripgrep \
slack \
starship \
tableplus \
wxwidgets \
zoxide \
zsh \
)

for i in "${packages[@]}"
do
  brew install "$i"
done

brew install --cask dash

$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

brew cleanup
