source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/extractt", from:oh-my-zsh
# zplug "plugins/emacs", from:oh-my-zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "chrissicool/zsh-256color"
zplug "kiurchv/asdf.plugin.zsh"
zplug "dracula/zsh", as:theme

if ! zplug check; then
    zplug install
fi
zplug load
