-- nvim config
--
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/LazyVim/LazyVim
-- https://github.com/NvChad/NvChad
-- https://github.com/LunarVim/LunarVim
-- https://github.com/ThePrimeagen/init.lua
-- https://github.com/jdhao/nvim-config
-- https://github.com/LunarVim/nvim-basic-ide
-- https://github.com/LazyVim/starter
-- https://github.com/mhanberg/.dotfiles/tree/main/config/nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins")
require("config.options")
require("config.autocmds")
require("config.keymaps")
