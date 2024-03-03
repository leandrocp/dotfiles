return {
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
    },
    config = function()
      vim.g.lazygit_use_neovim_remote = false
      vim.g.lazygit_floating_window_use_plenary = 1
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = "MarkdownPreview",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
