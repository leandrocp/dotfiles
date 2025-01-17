source ~/.sensitive
source ~/.shell/zinit
source ~/.shell/path
source ~/.shell/options
source ~/.shell/aliases

source <(fzf --zsh)
eval "$(zoxide init --cmd j zsh)"
# eval "$(/opt/homebrew/bin/mise activate zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
