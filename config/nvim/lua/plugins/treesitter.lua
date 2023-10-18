return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "markdown",
          "markdown_inline",
          "regex",
          "lua",
          "yaml",
          "json",
          "javascript",
          "html",
          "css",
          "erlang",
          "elixir",
          "eex",
          "heex",
          "rust"
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

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
      })
    end,
  },
}
