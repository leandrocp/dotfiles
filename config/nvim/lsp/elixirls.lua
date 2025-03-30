---@type vim.lsp.Config
return {
  cmd = { "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { ".git", "mix.exs", ".iex.exs" },
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
}
