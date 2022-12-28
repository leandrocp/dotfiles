return {
  "vim-test/vim-test",
  init = function()
    vim.cmd([[
        let g:test#preserve_screen = 1
        let test#strategy = "kitty"
      ]])
  end
}
