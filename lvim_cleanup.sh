#!/usr/bin/env bash

rm -f ~/.config/lvim/plugin/packer_compiled.lua
# rm -f ~/.cache/lvim/luacache*
# rm -f ~/.cache/lvim/lvim_cache
lvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync' -c 'LuaCacheClear'
