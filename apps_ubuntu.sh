#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest packages
sudo apt-get update

sudo apt-get install aptitude -y

sudo apt-get install build-essential cmake -y
sudo apt-get install python-dev -y

sudo apt-get install exuberant-ctags -y
sudo apt-get install ack-grep -y
sudo apt-get install silversearcher-ag -y
sudo apt-get install astyle -y
sudo apt-get install tidy -y

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt-get install neovim -y
sudo apt-get install editorconfig -y

sudo apt-get install python-software-properties software-properties-common -y
sudo add-apt-repository ppa:pi-rho/dev -y
sudo apt-get update
sudo apt-get install tmux=1.9a-1~ppa1~t -y
