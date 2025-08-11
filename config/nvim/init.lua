if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end

require("config.options")
require("config.lazy")
require("config.lsp")
require("config.keymaps")
require("config.autocmds")
-- vim.cmd.colorscheme("catppuccin-frappe")
-- vim.cmd.colorscheme("github_light_default")
vim.cmd.colorscheme("tokyonight-moon")
