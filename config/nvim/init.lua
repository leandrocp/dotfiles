-- nvim config
--
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/LazyVim/LazyVim
-- https://github.com/NvChad/NvChad
-- https://github.com/LunarVim/LunarVim
-- https://github.com/ThePrimeagen/init.lua
-- https://github.com/jdhao/nvim-config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.options")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.mappings")
  end,
})

vim.keymap.set('n', '<C-h>', "<cmd>KittyNavigateLeft<cr>")
vim.keymap.set('n', '<C-j>', "<cmd>KittyNavigateDown<cr>")
vim.keymap.set('n', '<C-k>', "<cmd>KittyNavigateUp<cr>")
vim.keymap.set('n', '<C-l>', "<cmd>KittyNavigateRight<cr>")
