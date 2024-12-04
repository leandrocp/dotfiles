return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      integrations = {
        cmp = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotest = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },

  "kyazdani42/nvim-web-devicons",

  {
    "declancm/maximize.nvim",
    config = true,
    keys = {
      { "<leader>wz", "<cmd>lua require('maximize').toggle()<cr>", desc = "Zoom" },
    },
    opts = {
      default_keymaps = false,
    },
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
    "romainl/vim-cool",
    event = "BufReadPost",
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
    "luukvbaal/statuscol.nvim",
    event = "UIEnter",
    config = function()
      require("statuscol").setup({
        setopt = true,
      })
    end,
  },

  {
    "LunarVim/bigfile.nvim",
    event = { "BufReadPre", "FileReadPre" },
    config = true,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<Leader>du", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
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
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  },

  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
  },

  { "numToStr/Comment.nvim", opts = {} },

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
    "windwp/nvim-spectre",
    event = "VeryLazy",
    keys = {
      { "<Leader>sr", "<cmd>lua require('spectre').open()<CR>", desc = "Replace" },
      {
        "<Leader>sR",
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
        desc = "Replace current word",
      },
    },

    config = true,
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
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    opts = {
      calm_down = true,
      virt_priority = 0,
    },
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
}
