return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },

  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },

  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 10,
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open_float()
        end,
        desc = "Explorer",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-o>"] = { "select_and_accept" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        elixir = { "mix" },
      },
    },
  },

  {
    "MunsMan/kitty-navigator.nvim",
    build = {
      "cp navigate_kitty.py ~/.config/kitty",
      "cp pass_keys.py ~/.config/kitty",
    },
    keys = {
      {
        "<C-h>",
        function()
          require("kitty-navigator").navigateLeft()
        end,
        desc = "move left",
        mode = { "n" },
      },
      {
        "<C-j>",
        function()
          require("kitty-navigator").navigateDown()
        end,
        desc = "move down",
        mode = { "n" },
      },
      {
        "<C-k>",
        function()
          require("kitty-navigator").navigateUp()
        end,
        desc = "move up",
        mode = { "n" },
      },
      {
        "<C-l>",
        function()
          require("kitty-navigator").navigateRight()
        end,
        desc = "move right",
        mode = { "n" },
      },
    },
  },

  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
    keys = {
      { "<Leader>se", "<cmd>A<CR>", desc = "Alternate File" },
    },
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = false },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
          }),
        },
        projectionist = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "tpope/vim-projectionist",
    },
  },

  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", ":TestNearest<CR>", desc = "Test Nearest" },
      { "<leader>tf", ":TestFile<CR>", desc = "Test File" },
      { "<leader>ts", ":TestSuite<CR>", desc = "Test Suite" },
      { "<leader>tl", ":TestLast<CR>", desc = "Test Last" },
    },
    config = function()
      vim.opt.shell = "bash"
      vim.g["test#custom_strategies"] = {
        snacks = function(cmd)
          require("snacks").terminal.open(cmd, {
            win = {
              relative = "editor",
              position = "bottom",
              enter = true,
              title = "Test",
            },
            interactive = false,
          })
        end,
      }
      vim.g["test#strategy"] = "snacks"
    end,
  },
}
