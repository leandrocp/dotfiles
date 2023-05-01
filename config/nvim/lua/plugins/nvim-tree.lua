return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeFocus", "NvimTreeToggle", "NvimTreeFindFile" },
  opts = {
    view = {
      adaptive_size = true,
      width = 35,
    },
    update_focused_file = {
      enable = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "mix.exs", "mix.lock" },
    },
    git = {
      ignore = false,
    },
  },
}
