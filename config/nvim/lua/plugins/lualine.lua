return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic"
  },
  event = "VeryLazy",
  config = function()
    local navic = require("nvim-navic")

    require("lualine").setup({
      options = {
        theme = 'catppuccin',
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
        disabled_filetypes = { "lazy", "spectre_panel", "lspinfo" }
      },
      sections = {
        lualine_c = {
          "filename",
          { navic.get_location, cond = navic.is_available },
        }
      },
      extensions = { "quickfix", "nvim-tree" }
    })
  end
}
