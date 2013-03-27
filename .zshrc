# ZSH INIT
if [ ! -d ~/.oh-my-zsh ]
then
  echo "\033[0;33mYou do not have Oh My Zsh installed.\033[0m See https://github.com/robbyrussell/oh-my-zsh"
  exit
fi

# VAR
ZSH=$HOME/.oh-my-zsh
DOTFILES=$HOME/.dotfiles

# OPTIONS / SHELL
source $HOME/.sensitive
source $DOTFILES/.shell/options
source $DOTFILES/.shell/aliases
source $DOTFILES/.shell/functions
source $DOTFILES/.shell/path
source $DOTFILES/.shell/cygwin/options
source $DOTFILES/.shell/cygwin/aliases
source $DOTFILES/.shell/cygwin/functions
source $DOTFILES/.shell/cygwin/path
source $DOTFILES/.shell/cygwin/empro

# ZSH
source $ZSH/oh-my-zsh.sh

# Go Home
if [[ "$OSTYPE" == "cygwin" ]]; then
  cd /cygdrive/c
else
  cd $HOME
fi
