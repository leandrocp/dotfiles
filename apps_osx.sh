#!/usr/bin/env bash

# https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed
brew install wget
brew install ack
brew install git
brew install tree
brew install htop-osx
brew install clang-format
brew install ctags
brew install ack
brew install the_silver_searcher
brew install fzf
brew install ripgrep
brew install editorconfig
brew install reattach-to-user-namespace
brew install tmux
brew install openssh
brew install ctags
brew install diff-so-fancy

brew cask install vlc
brew cask install iterm2

# Remove outdated versions from the cellar.
brew cleanup
