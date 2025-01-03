if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.sensitive
source $HOME/.shell/options
source $HOME/.shell/path
source $HOME/.shell/managers
source $HOME/.shell/zcomet
source $HOME/.shell/aliases
source $HOME/.shell/functions

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
