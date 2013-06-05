# PRE CHECK
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "\033[0;33mHey! You're not running ZSH and OH-MY-ZSH.\033[0m See: https://github.com/robbyrussell/oh-my-zsh"
  exit
fi

# SHELL
source $HOME/.sensitive
if [[ $OSTYPE == "cygwin" ]] ; then
  source $HOME/.shell/cygwin/options
  source $HOME/.shell/cygwin/aliases
  source $HOME/.shell/cygwin/functions
  source $HOME/.shell/cygwin/path
  source $HOME/.shell/cygwin/empro
else
  source $HOME/.shell/options
  source $HOME/.shell/aliases
  source $HOME/.shell/functions
  source $HOME/.shell/path
fi

# ZSH
fpath=(/usr/local/share/zsh-completions $fpath)
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# BASE16 COLORS
source $HOME/.base16-tomorrow.dark.sh

# INIT
if [[ "$OSTYPE" == "cygwin" ]]; then
  cd /cygdrive/c
else
  eval "$(rbenv init -)"
  eval "$(hub alias -s)"
fi
