#!/bin/sh

asdf plugin add neovim
asdf install neovim nightly
asdf global neovim nightly

asdf plugin add erlang
asdf install erlang 25.0.4
asdf global erlang 25.0.4

asdf plugin add elixir
asdf install elixir 1.14.2-otp-25
asdf global elixir 1.14.2-otp-25

asdf plugin add nodejs
asdf install nodejs 18.12.1
asdf global nodejs 18.12.1
