local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local options = {
  ensure_installed = {
    "lua",
    "json",
    "javascript",
    "erlang",
    "elixir",
    "eex",
    "heex"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

treesitter.setup(options)
