return {
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "document" },
          { "<leader>f", group = "file/find" },
          { "<leader>n", group = "navigate" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "<leader>o", group = "tools" },
          { "<leader>t", group = "test" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "scratch buffer",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "lazygit",
      },
      {
        "<leader>go",
        function()
          Snacks.gitbrowse()
        end,
        desc = "open browser",
      },
    },
  },

  {
    "echasnovski/mini.misc",
    config = function()
      local misc = require("mini.misc")
      misc.setup()
      misc.setup_auto_root({
        ".git",
        "mix.lock",
        "Makefile",
      })
      misc.setup_restore_cursor()
    end,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          d = { "%f[%d]%d+" }, -- digits
        },
      }
    end,
  },

  { "echasnovski/mini.icons", version = "*" },

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
        desc = "explorer",
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
    event = "BufReadPost",
    init = function()
      vim.g.projectionist_heuristics = {
        ["package.json"] = {
          ["package.json"] = { alternate = { "package-lock.json" } },
          ["package-lock.json"] = { alternate = { "package.json" } },
        },
        ["mix.exs"] = {
          ["mix.exs"] = { alternate = { "mix.lock" } },
          ["mix.lock"] = { alternate = { "mix.exs" } },
          ["lib/*.ex"] = {
            type = "source",
            alternate = "test/{}_test.exs",
            template = {
              "defmodule {camelcase|capitalize|dot} do",
              "end",
            },
          },
          ["test/*_test.exs"] = {
            type = "test",
            alternate = "lib/{}.ex",
            template = {
              "defmodule {camelcase|capitalize|dot}Test do",
              "  use ExUnit.Case, async: true",
              "",
              "  alias {camelcase|capitalize|dot}",
              "end",
            },
          },
        },
      }
    end,
    keys = {
      { "<Leader>sa", "<cmd>A<CR>", desc = "alternate file" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "symbols" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
}
