#!/bin/bash

# Based on:
# https://raw.github.com/mathiasbynens/dotfiles/master/bootstrap.sh
# https://github.com/holman/dotfiles/blob/master/script/bootstrap

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f ~/.gitconfig ]
  then
    info 'setup gitconfig'

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" .gitconfig.template > .gitconfig 

    success 'gitconfig'
  fi
}

function sync() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" --exclude ".gitconfig.template" --exclude ".sensitive" -av . ~
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  setup_gitconfig
  sync
fi

unset sync

source ~/.zshrc
