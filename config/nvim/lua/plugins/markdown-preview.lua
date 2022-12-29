return {
  "iamcco/markdown-preview.nvim",
  cmd = "MarkdownPreview",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
