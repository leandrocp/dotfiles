return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      term_colors = true,
      no_italic = true,
      integrations = {
        blink_cmp = true,
        fzf = true,
        gitsigns = true,
        grug_far = true,
        mini = { enabled = true },
        native_lsp = { enabled = true },
        overseer = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
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
          { "<leader>a", group = "AI" },
          { "<leader>c", group = "Code" },
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>i", group = "Inspect" },
          { "<leader>m", group = "Marks" },
          { "<leader>q", group = "Quit / Session" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Test / Tasks" },
          { "<leader>w", group = "Window / Tab" },
          { "<leader>d", group = "Diagnostics" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          {
            "<leader>b",
            group = "Buffer",
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
    event = "BufReadPost",
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
      bigfile = {
        enabled = true,
        size = 4 * 1024 * 1024,
      },
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
      picker = {},
      quickfile = { enabled = true },
      terminal = {},
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
        "<leader>go",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Open Browser",
      },

      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>;",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>gt",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>r",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>qp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "gs",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "gS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gB",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Branches",
      },
    },
  },

  {
    "echasnovski/mini.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local misc = require("mini.misc")
      misc.setup()
      misc.setup_auto_root({
        -- "mix.exs",
        -- "Cargo.toml",
        ".git",
        -- "mix.lock",
        -- "Makefile",
      })
      misc.setup_restore_cursor()

      require("mini.comment").setup()

      require("mini.ai").setup()

      require("mini.files").setup({
        mappings = {
          go_in_plus = "<CR>",
          go_out = "-",
        },
        windows = {
          preview = true,
          width_preview = 50,
        },
      })

      require("mini.jump").setup({
        mappings = {
          forward = "f",
          backward = "F",
          forward_till = "t",
          backward_till = "T",
          repeat_jump = ",",
        },
      })

      require("mini.move").setup()

      require("mini.surround").setup()

      require("mini.statusline").setup()
    end,
    keys = {
      {
        "-",
        function()
          if vim.fn.filereadable(vim.fn.bufname("%")) > 0 then
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
          else
            MiniFiles.open()
          end
        end,
        desc = "Explorer",
      },
      {
        "=",
        function()
          MiniFiles.open(MiniFiles.get_latest_path())
        end,
        desc = "Explorer Resume",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    keys = {
      {
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
        ["*"] = { "codespell", "typos" },
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        elixir = { "mix" },
        rust = { "rustfmt" },
        sh = { "shfmt", "shellharden", "beautysh" },
        bash = { "shfmt", "shellharden", "beautysh" },
        zsh = { "shfmt", "shellharden", "beautysh" },
        toml = { "taplo" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
      formatters = {
        injected = {
          ignore_errors = true,
        },
      },
      -- format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
      format_on_save = nil,
    },
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
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "next hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "prev hunk")

        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "stage hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
        map("n", "<leader>gR", gs.reset_buffer, "reset buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "preview hunk inline")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "blame line")
        map("n", "<leader>gB", function()
          gs.blame()
        end, "blame buffer")
        map("n", "<leader>gd", gs.diffthis, "diff")
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
      { "<Leader>cu", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
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
    config = function()
      vim.lsp.config("*", {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              -- Requires `watchman` to be installed https://github.com/facebook/watchman
              dynamicRegistration = true,
            },
          },
        },
      })

      -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
      for _, language_server in ipairs({
        "elixirls",
        "html",
        "jsonls",
        "lua_ls",
        "svelte",
        "yamlls",
        "rust_analyzer",
        "dockerls",
        "terraformls",
        "gopls",
      }) do
        vim.lsp.enable(language_server)
      end

      -- Missing leacy configs
      -- See https://github.com/neovim/nvim-lspconfig/issues/3705
      require("lspconfig")["tailwindcss"].setup({})

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = {
                "vim",
                "Snacks",
                "MiniFiles",
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.config("elixirls", {
        cmd = { "elixir-ls" },
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
            enableTestLenses = false,
          },
        },
      })
    end,
  },

  {
    "rgroli/other.nvim",
    cmd = { "Other", "OtherTabNew", "OtherSplit", "OtherVSplit", "OtherClose" },
    keys = {
      { "ga", "<Cmd>:Other<CR>", silent = true, desc = "Open alternative file" },
      { "gA", "<Cmd>:OtherSplit<CR>", silent = true, desc = "Open alternative file in split" },
    },
    config = function()
      require("other-nvim").setup({
        showMissingFiles = true,
        mappings = {
          "elixir",
          "rust",
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    lazy = false,
    opts = {
      keymap = {
        preset = "default",
        ["<C-o>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      cmdline = { sources = { "cmdline" } },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    cmd = { "Copilot", "CopilotChat" },
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gemini-2.5-pro",
    },
    keys = {
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests" },
      { "<leader>aa", ":CopilotChatToggle<CR>", mode = { "n", "x" }, desc = "Toggle Chat" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = { "TermExec" },
    version = "*",
    opts = {
      insert_mappings = true,
      terminal_mappings = true,
      direction = "vertical",
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.3
        end
      end,
    },
  },

  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Test: Suite" },
      { "<leader>tf", "<cmd>TestFile<CR>", desc = "Test: File" },
      { "<leader>tn", "<cmd>TestNearest<CR>", desc = "Test: Nearest" },
      { "<leader>tl", "<cmd>TestLast<CR>", desc = "Test: Last" },
    },
    config = function()
      vim.g["test#echo_command"] = 1
      vim.g["test#strategy"] = "toggleterm"

      vim.g["test#rust#cargotest#options"] = {
        nearest = "-- --nocapture",
      }
    end,
  },

  {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<leader>tr", "<cmd>OverseerRun<CR>", desc = "Task: Run" },
      { "<leader>tt", "<cmd>OverseerToggle<CR>", desc = "Task: List" },
      { "<leader>tb", "<cmd>OverseerBuild<CR>", desc = "Task: Build" },
      { "<leader>ta", "<cmd>OverseerTaskAction<CR>", desc = "Task: Action" },
      { "<leader>tq", "<cmd>OverseerQuickAction<CR>", desc = "Task: Recent" },
    },
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      local overseer = require("overseer")
      overseer.register_template({
        name = "mix docs",
        builder = function()
          return {
            cmd = { "mix", "docs" },
            components = {
              "default",
            },
            cwd = vim.fn.getcwd(),
          }
        end,
        desc = "mix docs",
      })
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>w",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "workspace",
      },
      {
        "<leader>db",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "buffer",
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "fnune/recall.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      local recall = require("recall")

      recall.setup({})

      vim.keymap.set("n", "<leader>mm", recall.toggle, { desc = "Toggle mark" })
      vim.keymap.set("n", "<leader>mn", recall.goto_next, { desc = "Next mark" })
      vim.keymap.set("n", "<leader>mp", recall.goto_prev, { desc = "Previous mark" })
      vim.keymap.set("n", "<leader>mc", recall.clear, { desc = "Clear marks" })
      vim.keymap.set("n", "<leader>k", require("recall.snacks").pick, { noremap = true, silent = true, desc = "List marks" })
    end,
  },
}
