local opt = vim.opt

opt.autoread = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0                                -- so that `` is visible in markdown files
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"                          -- the encoding written to a file
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.ignorecase = true
opt.ignorecase = true
opt.iskeyword:append("-")                           -- treats words with `-` as single words
opt.laststatus = 3
opt.mouse = "a"
opt.mousemodel = "extend"
opt.number = true
opt.numberwidth = 3
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 20
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.shiftwidth = 2
opt.showmode = false
opt.softtabstop = 2
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.titlestring = '%f'
opt.undofile = true
opt.updatetime = 200
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

vim.g.mkdp_filetypes = { "markdown" }

-- disable built-in vim plugins
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
