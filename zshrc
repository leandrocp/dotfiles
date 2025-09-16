source ~/.sensitive
source ~/.shell/zinit
source ~/.shell/options
source ~/.shell/aliases
source ~/.shell/path

source <(fzf --zsh)
eval "$(zoxide init --cmd j zsh)"

precmd() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    echo -ne "\033]0;$(basename "$PWD") [$branch]\007"
  else
    echo -ne "\033]0;$(basename "$PWD")\007"
  fi
}

preexec() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    echo -ne "\033]0;$1 in $(basename "$PWD") [$branch]\007"
  else
    echo -ne "\033]0;$1 in $(basename "$PWD")\007"
  fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
