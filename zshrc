# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="yyyy-mm-dd"
plugins=(brew safe-paste common-aliases command-not-found fzf ripgrep git gitfast asdf last-working-dir copyfile autojump man aws terraform docker docker-compose mix)
source $ZSH/oh-my-zsh.sh

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# user options
source $HOME/.sensitive
source $HOME/.shell/oh-my-zsh
source $HOME/.shell/options
source $HOME/.shell/path
source $HOME/.shell/managers
source $HOME/.shell/aliases
source $HOME/.shell/functions
