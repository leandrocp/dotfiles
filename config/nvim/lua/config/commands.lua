vim.cmd([[autocmd FileType markdown setlocal spell]])

-- -- highlight yanked region
-- vim.api.nvim_create_autocmd({ "TextYankPost" }, {
--   pattern = "*",
--   group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--   callback = function()
--     vim.highlight.on_yank { higroup = "Search", timeout = 200 }
--   end,
-- })

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
    "lspinfo",
    "lsp-installer",
    "null-ls-info",
    "tsplayground",
    "DressingSelect",
    "Jaq",
    "notify",
    "spectre_panel",
  },
  group = vim.api.nvim_create_augroup("buffer_mappings", {}),
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.bo[event.buf].buflisted = false
  end,
})

-- auto resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_resize", {}),
  command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
