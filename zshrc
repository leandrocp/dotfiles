# ZSH BUNDLES
source $HOME/.shell/bundles

# SHELL CONFIG
source $HOME/.sensitive
# *nix
source $HOME/.shell/options
source $HOME/.shell/path
source $HOME/.shell/managers
source $HOME/.shell/aliases
source $HOME/.shell/functions
source $HOME/.shell/completion
# win deprecated
source $HOME/.shell/cygwin/options
source $HOME/.shell/cygwin/path
source $HOME/.shell/cygwin/aliases
source $HOME/.shell/cygwin/functions
source $HOME/.shell/cygwin/empro

# TERMINAL THEME
# https://github.com/chriskempson/base16-shell
BASE16_SCHEME="twilight"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
source $BASE16_SHELL
export TERM=xterm-256color

# SSH
if [ -f /usr/bin/gnome-keyring-darmon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi

# TMUX
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
