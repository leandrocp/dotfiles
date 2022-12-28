return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  config = function()
    require("todo-comments").setup()
  end
}
