local present, lsp = pcall(require, "lsp-zero")

if not present then
  return
end

lsp.preset('recommended')

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
