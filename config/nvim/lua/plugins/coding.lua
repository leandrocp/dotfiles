return {
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = { use_diagnostic_signs = true },
  },

  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestClass", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    init = function()
      vim.cmd([[
        let g:test#preserve_screen = 1
        let g:test#echo_command = 0
        let test#strategy = "kitty"

        let g:test#elixir#exunit#options = "--trace"
      ]])
    end,
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test fearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
      {
        "<leader>td",
        function()
          vim.g["test#elixir#exunit#executable"] = "iex --dbg pry -S mix test"
          vim.cmd([[exec ":TestNearest"]])
          -- revert to mix test so it doesn't affect other cmds
          vim.g["test#elixir#exunit#executable"] = "mix test"
        end,
        desc = "Test debug",
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = false },
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            fetchDeps = false,
            dialyzerEnabled = false,
            suggestSpecs = false,
            autoInsertRequiredAlias = false,
          }),
          on_attach = function(client, bufnr)
            -- vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            -- vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          markdown = { "prettierd" },
          yaml = { "prettierd" },
          lua = { "stylua" },
          elixir = { "mix" },
          rust = { "rustfmt" },
          html = { "prettierd" },
          css = { "prettierd" },
          json = { "prettierd" },
          javascript = { "prettierd" },
          svelte = { "prettierd" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>df", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format" })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        svelte = { "eslint_d" },
        elixir = { "credo" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>dl", function()
        lint.try_lint()
      end, { desc = "Lint" })
    end,
  },

  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
