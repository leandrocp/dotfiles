#!/bin/sh

asdf plugin add neovim
asdf install neovim nightly
asdf global neovim nightly

asdf plugin add erlang

asdf plugin add elixir
asdf install elixir main-otp-25
asdf global elixir main-otp-25
