return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  config = function()
    require("nvim-tree").setup({
      view = {
        adaptive_size = true,
        width = 35,
      },
    })
  end
}
