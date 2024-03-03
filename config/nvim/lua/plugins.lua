return {
  "nvim-lua/plenary.nvim",

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup()

      require("which-key").register({
        ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
        ["<leader>n"] = { name = "Navigate", _ = "which_key_ignore" },
        ["<leader>o"] = { name = "Tools", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "Test", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "Windows", _ = "which_key_ignore" },
      })
    end,
  },

  {
    "echasnovski/mini.nvim",
    keys = {
      {
        "<leader>c",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Close buffer",
      },
    },
    config = function()
      local misc = require("mini.misc")
      misc.setup()
      misc.setup_auto_root({
        ".git",
        "mix.lock",
        "Makefile",
      })
      misc.setup_restore_cursor()

      require("mini.ai").setup({ n_lines = 500 })

      -- require("mini.surround").setup()
      -- require("mini.move").setup()

      local statusline = require("mini.statusline")
      statusline.setup()
      statusline.section_location = function()
        return ""
      end

      require("mini.bufremove")
    end,
  },
}
