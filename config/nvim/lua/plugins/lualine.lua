return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = 'catppuccin',
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          "filename",
          { "aerial", sep = " > " }
        }
      }
    })
  end
}
