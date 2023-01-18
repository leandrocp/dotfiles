return {
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   config = function()
  --     require("onedark").load()
  --   end
  -- },

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
            enabled = true
          }
        }
      })

      vim.cmd.colorscheme "catppuccin"
    end
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
    config = true
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle"
  },

  {
    "ojroques/nvim-bufdel",
    event = "BufReadPost"
  },

  "folke/which-key.nvim",

  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    config = true
  },

  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit"
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end
  },

  {
    "romainl/vim-cool",
    event = "BufReadPost"
  },

  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    config = true
  },

  {
    "knubie/vim-kitty-navigator",
    cmd = { "KittyNavigateLeft", "KittyNavigateDown", "KittyNavigateUp", "KittyNavigateRight" },
    build = "cp *.py ~/.config/kitty/",
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-elixir")
        }
      })
    end
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = { use_diagnostic_signs = true }
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = true
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "UIEnter",
    config = function()
      require("statuscol").setup({
        setopt = true,
      })
    end
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
      depth_limit = 3
    },
  },

  {
    "ggandor/flit.nvim",
    dependencies = {
      "ggandor/leap.nvim",
      config = function()
        require('leap').add_default_mappings()
      end
    },
    event = "VeryLazy",
    opts = {
      labeled_modes = "nv"
    }
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
        storage = "sqlite"
      },
      highlight = {
        timer = 200
      }
    },
  },
}
