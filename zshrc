# ZSH BUNDLES
source $HOME/.shell/zsh_plugins.sh
ZSH_THEME="leandrocp"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=1'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fffefe"

# SHELL CONFIG
source $HOME/.sensitive
source $HOME/.shell/options
source $HOME/.shell/path
source $HOME/.shell/managers
source $HOME/.shell/aliases
source $HOME/.shell/functions
source $HOME/.shell/completion

export TERM=xterm-256color
# export TERM=st-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
