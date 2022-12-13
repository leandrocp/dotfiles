local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

local options = {
  options = {
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
  }
}

bufferline.setup(options)
