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
#fpath=(/usr/local/share/zsh-completions $fpath)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# MANAGERS
which rbenv > /dev/null && eval "$(rbenv init -)"
which hub   > /dev/null && eval "$(hub alias -s)"

export NVM_DIR="/home/leandrocp/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# PATH
# It must be loaded after rbenv
source $HOME/.shell/path
source $HOME/.shell/cygwin/path

# TERMINAL THEME
# https://github.com/chriskempson/base16-shell
BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.colors/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL  ]] && . $BASE16_SHELL

