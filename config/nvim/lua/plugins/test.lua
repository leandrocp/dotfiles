return {
  "vim-test/vim-test",
  cmd = { "TestNearest", "TestClass", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  init = function()
    vim.cmd([[
        let g:test#preserve_screen = 1
        let test#strategy = "kitty"
      ]])
  end,
}
