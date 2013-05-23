# PRE CHECK
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "\033[0;33mYou do not have Oh My Zsh installed.\033[0m See https://github.com/robbyrussell/oh-my-zsh"
  exit
fi

# SHELL
source $HOME/.sensitive
source $HOME/.shell/options
source $HOME/.shell/aliases
source $HOME/.shell/functions
source $HOME/.shell/path
source $HOME/.shell/cygwin/options
source $HOME/.shell/cygwin/aliases
source $HOME/.shell/cygwin/functions
source $HOME/.shell/cygwin/path
source $HOME/.shell/cygwin/empro

# ZSH
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# GO HOME
if [[ "$OSTYPE" == "cygwin" ]]; then
  cd /cygdrive/c
else
  cd $HOME
fi
