return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        blink_cmp = true,
        fzf = true,
        gitsigns = true,
        grug_far = true,
        mason = true,
        neotest = true,
        treesitter = true,
        snacks = true,
        which_key = true,
      },
    },
  },

  {
    "https://github.com/fresh2dev/zellij.vim",
    lazy = true,
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "[", group = "prev" },
          { "]", group = "next" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps",
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mappings = {
          i = { k = { j = "<Esc>" } },
        },
      })
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { key = "n", desc = "New File", action = ":ene | startinsert" },
            { key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { key = "s", desc = "Restore Session", section = "session" },
            { key = "l", desc = "Lazy", action = ":Lazy" },
            { key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "keys", padding = 2 },
          { section = "recent_files", padding = 2 },
          { section = "projects", padding = 2 },
          { section = "startup" },
        },
      },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "LazyGit",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },

  {
    "echasnovski/mini.misc",
    version = "*",
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
    "stevearc/oil.nvim",
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
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>bf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix" },
        rust = { "rustfmt" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = { timeout_ms = 500 },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.case.new({
            types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
          }),
          augend.constant.new({
            elements = { "let", "const" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "and", "or" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "on", "off" },
            word = false,
            cyclic = true,
          }),
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "BufReadPost",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<CR>", desc = "Increment Selection" },
      { "<C-CR>", desc = "Decrement Selection", mode = "x" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "diff",
          "eex",
          "elixir",
          "erlang",
          "heex",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "regex",
          "rust",
          "svelte",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<C-CR>",
          },
        },
        textobjects = {
          select = {
            enable = true,
          },
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
          },
        },
      })
    end,
  },

  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, _opts)
      local actions = require("fzf-lua.actions")

      return {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          formatter = "path.dirname_first",
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      { "<leader>r", "<cmd>FzfLua resume<cr>", desc = "Resume Find/Search" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Files" },
      {
        "<leader>/",
        function()
          require("fzf-lua").live_grep_native({
            resume = true,
          })
        end,
        desc = "Grep",
      },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word" },
      {
        "gs",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Goto Symbol",
      },
      {
        "gS",
        function()
          require("fzf-lua").lsp_workspace_symbols()
        end,
        desc = "Goto Workspace Symbol",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    keys = {},
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]g", gs.next_hunk, "Next git chunk")
        map("n", "[g", gs.prev_hunk, "Prev git chunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage change")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset change")
        map("n", "<leader>gU", gs.undo_stage_hunk, "Undo stage change")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>gd", gs.diffthis, "Diff this")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Diff this ~")
      end,
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "romainl/vim-cool",
    event = "BufReadPost",
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<Leader>du", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
    },
  },

  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,
        show_cursorline = true,
      })
    end,
  },

  {
    "cpea2506/relative-toggle.nvim",
    event = "InsertEnter",
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
      },
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    init = function()
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      require("mason").setup({})

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "erlangls",
          "lua_ls",
          "rust_analyzer",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
        },
      })

      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          -- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
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
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
        },
        projectionist = {
          enable = true,
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    event = "InsertEnter",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
      },
      keymap = {
        preset = "default",
        ["<C-o>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
