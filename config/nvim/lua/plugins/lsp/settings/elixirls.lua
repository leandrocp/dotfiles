local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
	cmd = { "/Users/leandro/code/github/elixir-lsp/elixir-ls/release/language_server.sh" },
	capabilities = capabilities,
}
