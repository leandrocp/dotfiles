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
      enabled = true,
      update_cwd = true,
      update_root = true
    },
  }
}
