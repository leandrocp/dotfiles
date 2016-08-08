#!/usr/bin/env bash

# https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Brew Extras
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew tap choppsv1/term24

brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install macvim --override-system-vim --with-cscope --with-lua --with-ruby --with-python
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install ack
brew install git
brew install rename
brew install tree
brew install htop-osx
brew install hub
brew install clang-format
brew install ctags
brew install ack
brew install the_silver_searcher
brew install editorconfig
brew install reattach-to-user-namespace
brew install erlang
brew install watchman

brew cask install xquartz
brew cask install vlc
brew cask install iterm2-beta

brew install neovim/neovim/neovim

brew install choppsv1/term24/tmux

brew tap d12frosted/emacs-plus
brew install emacs-plus --with-cocoa --with-gnutls --with-librsvg --with-imagemagick --with-spacemacs-icon

# Link apps
brew linkapps

# Remove outdated versions from the cellar.
brew cleanup
