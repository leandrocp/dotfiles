local function augroup(name)
  return vim.api.nvim_create_augroup("leandrocp_" .. name, { clear = true })
end

-- reload changed file
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- map q to close
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("close_with_q"),
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
    "outputpanel",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.bo[event.buf].buflisted = false
  end,
})

-- auto resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- strip trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("strip_whitespace"),
  command = "%s/\\s\\+$//e",
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- open telescope on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.fn.argv() == 0 then
      vim.cmd("silent! lua require ('telescope.builtin').find_files()")
    end
  end,
})
