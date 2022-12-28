return {
  "iamcco/markdown-preview.nvim",
  -- ft = { "markdown" },
  -- cmd = "MarkdownPreview",
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}
