return {
  "akinsho/nvim-bufferline.lua",
  event = "BufAdd",
  dependencies = { "catppuccin/nvim" },
  opts = {
    options = {
      separator_style = "thin",
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "undotree",
          text = "Undotree",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "Directory",
          padding = 1,
        },
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          highlight = "PanelHeading",
        },
        {
          filetype = "packer",
          text = "Packer",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
    },
    highlights = require("catppuccin.groups.integrations.bufferline").get()
  }
}
