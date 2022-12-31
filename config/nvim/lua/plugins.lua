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
          neotree = true,
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
    config = function()
      require("dressing").setup()
    end
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
    config = function()
      require("marks").setup()
    end
  },

  {
    "tpope/vim-repeat",
    event = "BufReadPost"
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit"
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    config = function()
      require("aerial").setup()
    end
  },

  {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    config = function()
      require("nvim-autopairs").setup()
    end
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
    config = function()
      require("spectre").setup()
    end,
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
    config = function()
      require("trouble").setup {
      }
    end
  },
}
