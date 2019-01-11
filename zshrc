# ZSH BUNDLES
source $HOME/.shell/bundles

# SHELL CONFIG
source $HOME/.sensitive
source $HOME/.shell/options
source $HOME/.shell/path
source $HOME/.shell/managers
source $HOME/.shell/aliases
source $HOME/.shell/functions
source $HOME/.shell/completion

# TERMINAL THEME
# https://github.com/chriskempson/base16-shell
# BASE16_SCHEME="eighties"
# BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-$BASE16_SCHEME.sh"
# source $BASE16_SHELL
export TERM=xterm-256color

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
export BASE17_THEME=spacemacs

# TMUX
source ~/.bin/tmuxinator.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
