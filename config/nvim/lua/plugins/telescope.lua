return {
  "nvim-telescope/telescope.nvim",
  version = false,
  event = "VeryLazy",
  dependencies = {
    -- {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    --   build = "make",
    -- },
    {
      "natecraddock/telescope-zf-native.nvim"
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
}
