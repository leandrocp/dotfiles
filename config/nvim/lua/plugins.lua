return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require("onedark").load()
    end
  },

  "nvim-lua/plenary.nvim",

  "tpope/vim-sleuth",

  {
    "stevearc/dressing.nvim",
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

  "JoosepAlviste/nvim-ts-context-commentstring",

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
    build = "cp *.py ~/.config/kitty/",
  },
}
