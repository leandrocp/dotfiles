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

  "nvim-lua/plenary.nvim",

  "kyazdani42/nvim-web-devicons",

  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "ojroques/nvim-bufdel",
    event = "BufReadPost",
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
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.g.lazygit_use_neovim_remote = false
      vim.g.lazygit_floating_window_use_plenary = 1
    end
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "romainl/vim-cool",
    event = "BufReadPost",
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

  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true
      require("util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = {
      highlight = true,
      depth_limit = 3,
    },
  },

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
    version = "*",
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
    version = "*",
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
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
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
          { "n", "u",     "undo", {} },
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
    config = true
  },

  {
    'ThePrimeagen/harpoon',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true
  }
}
