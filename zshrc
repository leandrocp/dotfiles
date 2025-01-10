source ~/.sensitive
source ~/.shell/zinit
source ~/.shell/path
source ~/.shell/options
source ~/.shell/aliases

source <(fzf --zsh)
eval "$(zoxide init --cmd j zsh)"
eval "$(/opt/homebrew/bin/mise activate zsh)"
