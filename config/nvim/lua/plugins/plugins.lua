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
    "https://github.com/fresh2dev/zellij.vim.git",
    event = "VeryLazy",
    keys = {
      { "<C-h>", ":ZellijNavigateLeft<CR>", mode = { "n" }, { noremap = true } },
      { "<C-j>", ":ZellijNavigateDown<CR>", mode = { "n", "i" }, { noremap = true } },
      { "<C-k>", ":ZellijNavigateUp<CR>", mode = { "n", "i" }, { noremap = true } },
      { "<C-l>", ":ZellijNavigateRight<CR>", mode = { "n", "i" }, { noremap = true } },
      { "<D-j>", "<cmd>ZellijNewPaneSplit<CR>", { silent = true, desc = "Split Down" } },
      { "<D-l>", "<cmd>ZellijNewPaneVSplit<CR>", { silent = true, desc = "Split Right" } },
    },
    config = function()
      -- Autocommand which names the current Zellij tab after Vim's current working directory
      vim.api.nvim_create_autocmd({ "DirChanged", "WinEnter", "BufEnter" }, {
        pattern = "*",
        callback = function()
          vim.fn.system('zellij action rename-tab "' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. '"')
        end,
      })
    end,
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
      vim.g["test#custom_strategies"] = {
        snacks = function(cmd)
          require("snacks").terminal(cmd, {
            win = {
              style = "terminal",
              relative = "editor",
              position = "bottom",
              enter = true,
              title = "Test",
            },
            interactive = false,
          })
          vim.cmd("stopinsert")
          vim.cmd("normal! G")
        end,
      }
      vim.g["test#strategy"] = "snacks"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<CR>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
}
