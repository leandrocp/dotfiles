local is_inside_work_tree = {}
local function project_files()
  local builtin = require("telescope.builtin")
  local opts = {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
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

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "projects")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>r", builtin.resume, { desc = "Resume search" })
      vim.keymap.set("n", "<leader>;", builtin.command_history, { desc = "Command history" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep" })
      vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>f", project_files, { desc = "Find file" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Files" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Current word" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
      vim.keymap.set("n", "<leader>sp", "<cmd>Telescope projects<cr>", { desc = "Projects" })
      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo list" })
      vim.keymap.set(
        "n",
        "<leader>sy",
        "<cmd>:lua require('telescope').extensions.yank_history.yank_history()<cr>",
        { desc = "Yank history" }
      )
    end,
  },

  -- {
  --   "ThePrimeagen/harpoon",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = true,
  -- },

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

  --   e = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   cmd = { "NvimTreeFocus", "NvimTreeToggle", "NvimTreeFindFile" },
  --   opts = {
  --     view = {
  --       adaptive_size = true,
  --       width = 35,
  --     },
  --     update_focused_file = {
  --       enable = true,
  --     },
  --     renderer = {
  --       indent_markers = {
  --         enable = true,
  --       },
  --       special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "mix.exs", "mix.lock" },
  --     },
  --     git = {
  --       ignore = false,
  --     },
  --   },
  -- },

  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Explorer" },
    },
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "knubie/vim-kitty-navigator",
    cmd = { "KittyNavigateLeft", "KittyNavigateDown", "KittyNavigateUp", "KittyNavigateRight" },
    build = "cp *.py ~/.config/kitty/",
  },
}
