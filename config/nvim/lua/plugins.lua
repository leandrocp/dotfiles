return {
  "nvim-lua/plenary.nvim",

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "document" },
          { "<leader>f", group = "file/find" },
          { "<leader>n", group = "navigate" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "<leader>o", group = "tools" },
          { "<leader>t", group = "test" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
        },
      },
    },
    -- config = function()
    --   require("which-key").setup()
    --
    --   require("which-key").register({
    --     ["<leader>b"] = { name = "Buffer", _ = "which_key_ignore" },
    --     ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
    --     ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
    --     ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
    --     ["<leader>n"] = { name = "Navigate", _ = "which_key_ignore" },
    --     ["<leader>o"] = { name = "Tools", _ = "which_key_ignore" },
    --     ["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
    --     ["<leader>t"] = { name = "Test", _ = "which_key_ignore" },
    --     ["<leader>w"] = { name = "Windows", _ = "which_key_ignore" },
    --   })
    -- end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
    },
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      -- {
      --   "<leader>bd",
      --   function()
      --     Snacks.bufdelete()
      --   end,
      --   desc = "Delete Buffer",
      -- },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>go",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Open Browser",
      },
    },
  },

  {
    "echasnovski/mini.misc",
    config = function()
      local misc = require("mini.misc")
      misc.setup()
      misc.setup_auto_root({
        ".git",
        "mix.lock",
        "Makefile",
      })
      misc.setup_restore_cursor()

      -- require("mini.surround").setup()
      -- require("mini.move").setup()

      -- local statusline = require("mini.statusline")
      -- statusline.setup()
      -- statusline.section_location = function()
      --   return ""
      -- end
    end,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          d = { "%f[%d]%d+" }, -- digits
        },
      }
    end,
  },

  { "echasnovski/mini.icons", version = "*" },
}
