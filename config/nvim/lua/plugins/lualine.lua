return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = 'onedark',
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      }
    })
  end
}
