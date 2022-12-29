vim.cmd [[colorscheme onedark]]

vim.o.laststatus = 3
vim.o.showmode = false
vim.o.title = true

vim.o.clipboard = "unnamedplus"
vim.o.autoread = true
vim.o.cursorline = true

-- Indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = "a"

-- Numbers
vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.relativenumber = true
vim.o.scrolloff = 20

vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.timeoutlen = 400
vim.o.undofile = true
vim.o.wrap = false
vim.opt.spelllang = { "en" }

vim.g.mkdp_filetypes = { "markdown" }

-- interval for writing swap file to disk, also used by gitsigns
vim.o.updatetime = 200

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- vim.o.whichwrap:append "<>[]hl"

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
