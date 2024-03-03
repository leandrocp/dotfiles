return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          cmp = true,
          gitsigns = true,
          mason = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
          lsp_trouble = true,
          which_key = true,
          native_lsp = {
            enabled = true,
          },
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },

  "kyazdani42/nvim-web-devicons",

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
    },
  },

  {
    "ojroques/nvim-bufdel",
    event = "BufReadPost",
  },

  {
    "romainl/vim-cool",
    event = "BufReadPost",
  },

  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  "nvim-lua/plenary.nvim",

  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFocus", "NvimTreeToggle", "NvimTreeFindFile" },
    opts = {
      view = {
        adaptive_size = true,
        width = 35,
      },
      update_focused_file = {
        enable = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "mix.exs", "mix.lock" },
      },
      git = {
        ignore = false,
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
        -- TODO: managed by elixir-tools
        -- ["mix.exs"] = {
        --   ["mix.exs"] = { alternate = { "mix.lock" } },
        --   ["mix.lock"] = { alternate = { "mix.exs" } },
        --   ["lib/*.ex"] = {
        --     type = "source",
        --     alternate = "test/{}_test.exs",
        --     template = {
        --       "defmodule {camelcase|capitalize|dot} do",
        --       "end",
        --     },
        --   },
        --   ["test/*_test.exs"] = {
        --     type = "test",
        --     alternate = "lib/{}.ex",
        --     template = {
        --       "defmodule {camelcase|capitalize|dot}Test do",
        --       "  use ExUnit.Case, async: true",
        --       "",
        --       "  alias {camelcase|capitalize|dot}",
        --       "end",
        --     },
        --   },
        -- },
      }
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    event = "WinNew",
    config = function()
      require("smart-splits").setup({
        tmux_integration = false,
      })
    end,
  },

  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    init = function()
      vim.keymap.set({ "n", "o", "x" }, "w", function()
        require("spider").motion("w")
      end, { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", function()
        require("spider").motion("e")
      end, { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", function()
        require("spider").motion("b")
      end, { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", function()
        require("spider").motion("ge")
      end, { desc = "Spider-ge" })
    end,
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
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test Suite" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
      {
        "<leader>td",
        function()
          vim.g["test#elixir#exunit#executable"] = "iex --dbg pry -S mix test"
          vim.cmd([[exec ":TestNearest"]])
          -- revert to mix test so it doesn't affect other cmds
          vim.g["test#elixir#exunit#executable"] = "mix test"
        end,
        desc = "Test Debug",
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
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    version = false,
    event = "VeryLazy",
    dependencies = {
      -- {
      --   "nvim-telescope/telescope-fzf-native.nvim",
      --   build = "make",
      -- },
      {
        "natecraddock/telescope-zf-native.nvim",
      },
      -- {
      --   "nvim-telescope/telescope-github.nvim",
      --   config = function()
      --     require("telescope").load_extension("gh")
      --   end
      -- }
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup({
            detection_methods = { "pattern" },
            patterns = { ".git", "Makefile", "mix.lock", "Cargo.toml" },
          })
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { "node_modules", ".elixir_ls", "_build" },
          path_display = { "truncate" },
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          mappings = {
            n = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
            i = {
              -- ["<esc>"] = actions.close,
              ["<C-j>"] = { actions.move_selection_next, type = "action", opts = { nowait = true, silent = true } },
              ["<C-k>"] = { actions.move_selection_previous, type = "action", opts = { nowait = true, silent = true } },
              ["<C-[>"] = actions.cycle_history_next,
              ["<C-]>"] = actions.cycle_history_prev,
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      })

      telescope.load_extension("zf-native")
      telescope.load_extension("projects")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "JoosepAlviste/nvim-ts-context-commentstring",
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
          "rust",
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

        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },

          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            },
          },
        },
      })
    end,
  },
  --
  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/lazy-loading-with-lazy-nvim.md
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()

      lsp_zero.extend_cmp()

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "copilot" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<C-c>"] = cmp.mapping.close(),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "SmiteshP/nvim-navic" },
      { "simrat39/rust-tools.nvim" },
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- lsp_zero.default_keymaps({ buffer = bufnr })

        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
        })

        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
      end)

      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer" },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          rust_analyzer = function()
            local rust_tools = require("rust-tools")

            rust_tools.setup({
              server = {
                on_attach = function(client, bufnr)
                  -- vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                end,
              },
            })
          end,
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    event = "VeryLazy",
    config = function()
      local navic = require("nvim-navic")

      require("lualine").setup({
        options = {
          theme = "catppuccin",
          icons_enabled = false,
          component_separators = "|",
          section_separators = "",
          globalstatus = true,
          disabled_filetypes = { "lazy", "spectre_panel", "lspinfo" },
        },
        sections = {
          lualine_c = {
            "tabs",
            {
              "filename",
              path = 1,
            },
            { navic.get_location, cond = navic.is_available },
          },
        },
        extensions = { "quickfix", "nvim-tree" },
      })
    end,
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
    "iamcco/markdown-preview.nvim",
    cmd = "MarkdownPreview",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "kj" },
      })
    end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.g.lazygit_use_neovim_remote = false
      vim.g.lazygit_floating_window_use_plenary = 1
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    config = true,
  },

  {
    "knubie/vim-kitty-navigator",
    cmd = { "KittyNavigateLeft", "KittyNavigateDown", "KittyNavigateUp", "KittyNavigateRight" },
    build = "cp *.py ~/.config/kitty/",
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = { use_diagnostic_signs = true },
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "UIEnter",
    config = function()
      require("statuscol").setup({
        setopt = true,
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- {
  --   "SmiteshP/nvim-navic",
  --   init = function()
  --     vim.g.navic_silence = true
  --     require("util").on_attach(function(client, buffer)
  --       if client.server_capabilities.documentSymbolProvider then
  --         require("nvim-navic").attach(client, buffer)
  --       end
  --     end)
  --   end,
  --   opts = {
  --     highlight = true,
  --     depth_limit = 3,
  --   },
  -- },

  {
    "gbprod/yanky.nvim",
    dependencies = "kkharji/sqlite.lua",
    event = "VeryLazy",
    init = function()
      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
    end,
    opts = {
      ring = {
        storage = "sqlite",
      },
      highlight = {
        timer = 200,
      },
    },
  },

  {
    "echasnovski/mini.misc",
    lazy = false,
    version = false,
    config = function()
      require("mini.misc").setup()

      require("mini.misc").setup_auto_root({
        ".git",
        "mix.lock",
        "Makefile",
      })

      require("mini.misc").setup_restore_cursor()
    end,
  },

  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    version = false,
    config = true,
  },

  -- {
  --   "mhanberg/output-panel.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("output_panel").setup()
  --   end,
  -- },

  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    opts = {
      calm_down = true,
      virt_priority = 0,
    },
  },

  {
    "LunarVim/bigfile.nvim",
    event = { "BufReadPre", "FileReadPre" },
    config = true,
  },

  {
    "tzachar/highlight-undo.nvim",
    config = function()
      require("highlight-undo").setup({
        hlgroup = "HighlightUndo",
        duration = 300,
        keymaps = {
          { "n", "u", "undo", {} },
          { "n", "<C-r>", "redo", {} },
        },
      })
    end,
  },

  {
    "cpea2506/relative-toggle.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "kevinhwang91/nvim-bqf",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufRead", "BufNew" },
    config = true,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  },

  {
    "declancm/maximize.nvim",
    config = true,
    opts = {
      default_keymaps = false,
    },
  },

  {
    "j-hui/fidget.nvim",
    config = true,
  },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   config = function()
  --     require("noice").setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     })
  --   end,
  -- },

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
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

      vim.keymap.set({ "n", "v" }, "<leader>bf", function()
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

      vim.keymap.set("n", "<leader>bl", function()
        lint.try_lint()
      end, { desc = "Lint" })
    end,
  },

  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
}
