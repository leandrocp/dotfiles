return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "json",
          "javascript",
          "html",
          "css",
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
      })
    end
  }
}
