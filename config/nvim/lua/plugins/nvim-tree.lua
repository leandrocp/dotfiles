return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  opts = {
    view = {
      adaptive_size = true,
      width = 35,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true
    },
    renderer = {
      indent_markers = {
        enable = true
      },
      special_files = {}
    },
    git = {
      ignore = false
    },
  }
}
