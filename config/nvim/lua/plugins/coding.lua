return {
  -- {
  --   "tpope/vim-sleuth",
  --   event = "VeryLazy",
  -- },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "jfpedroza/neotest-elixir",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        "neotest-elixir",
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          require("trouble").open({ mode = "quickfix", focus = false })
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      opts.consumers = opts.consumers or {}
      -- Refresh and auto close trouble after running tests
      ---@type neotest.Consumer
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then
            return
          end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))

          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == "failed" and tree:get_key(pos_id) then
              failed = failed + 1
            end
          end
          vim.schedule(function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then
                trouble.close()
              end
            end
          end)
          return {}
        end
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      {"<leader>t", "", desc = "test"},
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "file" },
      { "<leader>ts", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "suite" },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "last" },
      { "<leader>tm", function() require("neotest").summary.toggle() end, desc = "summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "output" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "watch" },
    },
  },

  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "jfpedroza/neotest-elixir",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   lazy = false,
  --   cmd = "Neotest",
  --   keys = {
  --     {
  --       "<leader>tf",
  --       function()
  --         require("neotest").run.run(vim.fn.expand("%"))
  --       end,
  --       desc = "file",
  --     },
  --     {
  --       "<leader>tn",
  --       function()
  --         require("neotest").run.run()
  --       end,
  --       desc = "nearest",
  --     },
  --     {
  --       "<leader>tl",
  --       function()
  --         require("neotest").run.run_last()
  --       end,
  --       desc = "last",
  --     },
  --     {
  --       "<leader>to",
  --       function()
  --         require("neotest").output_panel.toggle()
  --       end,
  --       desc = "output",
  --     },
  --     {
  --       "<leader>tc",
  --       function()
  --         require("neotest").output_panel.clear()
  --       end,
  --       desc = "clear output",
  --     },
  --   },
  --   config = function()
  --     local neotest = require("neotest")
  --     neotest.setup({
  --       adapters = {
  --         require("neotest-elixir"),
  --       },
  --       status = { virtual_text = true },
  --       output = { open_on_run = true },
  --       quickfix = {
  --         open = function()
  --           require("trouble").open({ mode = "quickfix", focus = false })
  --         end,
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "jfpedroza/neotest-elixir",
  --   },
  --   cmd = "Neotest",
  --   opts = {
  --     adapters = {
  --       ["neotest-elixir"] = {},
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>tf",
  --       function()
  --         require("neotest").run.run(vim.fn.expand("%"))
  --       end,
  --       desc = "file",
  --     },
  --
  --     {
  --       "<leader>tn",
  --       function()
  --         require("neotest").run.run()
  --       end,
  --       desc = "nearest",
  --     },
  --   },
  -- },

  -- {
  --   "vim-test/vim-test",
  --   cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast" },
  --   init = function()
  --     vim.cmd([[
  --       let g:test#preserve_screen = 1
  --       let g:test#echo_command = 0
  --       let test#strategy = "kitty"
  --
  --       " let g:test#elixir#exunit#options = "--trace"
  --     ]])
  --   end,
  --   keys = {
  --     { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test fearest" },
  --     { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
  --     { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
  --     { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
  --     {
  --       "<leader>td",
  --       function()
  --         vim.g["test#elixir#exunit#executable"] = "iex --dbg pry -S mix test"
  --         vim.cmd([[exec ":TestNearest"]])
  --         -- revert to mix test so it doesn't affect other cmds
  --         vim.g["test#elixir#exunit#executable"] = "mix test"
  --       end,
  --       desc = "Test debug",
  --     },
  --   },
  -- },

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

  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require("elixir")
  --     local elixirls = require("elixir.elixirls")
  --
  --     elixir.setup({
  --       nextls = { enable = true },
  --       credo = { enable = false },
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings({
  --           fetchDeps = false,
  --           dialyzerEnabled = false,
  --           suggestSpecs = false,
  --           autoInsertRequiredAlias = false,
  --           enableTestLeads = false,
  --         }),
  --       },
  --     })
  --   end,
  -- },

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

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- vim.keymap.set("n", "<leader>cR", function()
          --   vim.cmd.RustLsp("codeAction")
          -- end, { desc = "Code Action", buffer = bufnr })
          -- vim.keymap.set("n", "<leader>dr", function()
          --   vim.cmd.RustLsp("debuggables")
          -- end, { desc = "Rust debuggables", buffer = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
