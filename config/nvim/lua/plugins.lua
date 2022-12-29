return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require("onedark").load()
    end
  },

  "nvim-lua/plenary.nvim",

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
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
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
}
