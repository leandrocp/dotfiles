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
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- map q to close
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "floaterm",
    "lspinfo",
    "lir",
    "lsp-installer",
    "null-ls-info",
    "tsplayground",
    "DressingSelect",
    "Jaq",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
    vim.opt_local.buflisted = false
  end,
})

-- auto resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_resize", {}),
  command = "tabdo wincmd =",
})
