#!/bin/sh

# https://github.com/thoughtbot/dotfiles/blob/master/install.sh

function install() {
  for name in *; do
    target="$HOME/.$name"

    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'oh-my-zsh' ] && [ "$name" != 'vscode' ] && [ "$name" != 'emacs.d' ]; then
      rm -rf "$target"
      echo "ln -s "$PWD/$name" "$target""
      ln -s "$PWD/$name" "$target"
    fi
  done

  touch ~/.sensitive

  mkdir -p ~/.tmux/plugins
  mkdir -p ~/.tmux/themes
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  # mkdir ~/.emacs.d
  ln -s ~/.emacs.d/init.el ~/.emacs.d/init.el
  ln -s /Applications/Emacs.app/Contents/MacOS/bin/emacsclient ~/.bin/emacsclient

  rm -f ~/Library/Application\ Support/VSCodium/User/settings.json
  rm -f ~/Library/Application\ Support/VSCodium/User/keybindings.json
  rm -f ~/Library/Application\ Support/Code/VSCodium/snippets
  ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/VSCodium/User/settings.json
  ln -s ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/VSCodium/User/keybindings.json
  ln -s ~/.dotfiles/vscode/snippets ~/Library/Application\ Support/Code/VSCodium/snippets

  ln -s ~/.dotfiles/sublime ~/Library/Application\ Support/Sublime\ Text/Packages/User
}

install
