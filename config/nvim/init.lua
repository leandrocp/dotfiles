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
require("config.keymaps")
require("config.autocmds")
vim.cmd.colorscheme("catppuccin-frappe")
vim.api.nvim_set_hl(0, "MiniJump", { fg = "#ffffff", bg = "#626880" })
