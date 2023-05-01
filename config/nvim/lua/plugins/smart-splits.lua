return {
  "mrjones2014/smart-splits.nvim",
  event = "WinNew",
  config = function()
    require("smart-splits").setup({
      tmux_integration = false,
    })
  end,
}
