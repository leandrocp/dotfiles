# IS OH-MY-ZSH INSTALLED ?
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "\033[0;33mHey! You're not running ZSH and OH-MY-ZSH.\033[0m See: https://github.com/robbyrussell/oh-my-zsh"
  exit
fi

# SHELL CONFIG
source $HOME/.sensitive
source $HOME/.shell/options
source $HOME/.shell/aliases
source $HOME/.shell/functions
source $HOME/.shell/completion
source $HOME/.shell/cygwin/options
source $HOME/.shell/cygwin/aliases
source $HOME/.shell/cygwin/functions
source $HOME/.shell/cygwin/empro

# ZSH
fpath=(/usr/local/share/zsh-completions $fpath)
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# SCRIPTS
#which rbenv > /dev/null && eval "$(rbenv init -)"
eval "$(rbenv init -)"
which hub > /dev/null && eval "$(hub alias -s)"
which vault > /dev/null && eval "$( vault --initpath )"

# PATH
# It must be loaded after rbenv
source $HOME/.shell/path
source $HOME/.shell/cygwin/path

# TERMINAL THEME
source $HOME/.base16-tomorrow.dark.sh

# INIT
if [[ "$OSTYPE" == "cygwin" ]]; then
  cd /cygdrive/c
fi
