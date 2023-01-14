#!/bin/sh

asdf plugin add neovim
asdf install neovim nightly
asdf global neovim nightly

asdf plugin add erlang
asdf install erlang latest
asdf global erlang latest

asdf plugin add elixir
asdf install elixir latest
asdf global elixir latest

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
