# ZSH BUNDLES
source $HOME/.antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  osx
  cp
  extract
  autojump
  tmux
  ruby
  gem
  rbenv
  bundler
  npm
  git
  svn
  brew
  aws
  zsh-users/zsh-completions src
  zsh-users/zsh-syntax-highlighting
  nojhan/liquidprompt
EOBUNDLES
antigen apply

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

# PATH
# It must be loaded after rbenv
source $HOME/.shell/path
source $HOME/.shell/cygwin/path

# ENV MANAGERS
source $HOME/.shell/managers

# TERMINAL THEME
# https://github.com/chriskempson/base16-shell
BASE16_SCHEME="tomorrow"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
source $BASE16_SHELL


export TERM=xterm-256color
