vim.cmd([[autocmd FileType markdown setlocal spell]])

-- highlight yanked region
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "Search", timeout = 200 }
  end,
})

-- reload changed file
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
