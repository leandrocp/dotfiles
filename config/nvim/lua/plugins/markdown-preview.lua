return {
  "iamcco/markdown-preview.nvim",
  cmd = "MarkdownPreview",
  ft = { "markdown" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}
