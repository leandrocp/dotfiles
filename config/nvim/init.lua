vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/cpea2506/relative-toggle.nvim",
  "https://github.com/echasnovski/mini.nvim",
  -- "https://github.com/fnune/recall.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/sidekick.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/max397574/better-escape.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/mg979/vim-visual-multi",
  "https://github.com/monaqa/dial.nvim",
  "https://github.com/nacro90/numb.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/rgroli/other.nvim",
  "https://github.com/romainl/vim-cool",
  -- "https://github.com/sindrets/diffview.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/overseer.nvim",
  "https://github.com/vim-test/vim-test",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
}, { load = true, confirm = false })

vim.cmd([[colorscheme tokyonight]])

--
-- options
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.ignorecase = true
opt.inccommand = "split"
opt.iskeyword:append({ "-" })
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.mousemodel = "extend"
opt.number = true
opt.numberwidth = 5
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 20
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.titlestring = "%f"
opt.undofile = true
opt.updatetime = 200
opt.wildmode = "longest:full,full"
opt.autoread = true
opt.winminwidth = 5
opt.wrap = false
vim.g.mkdp_filetypes = { "markdown" }

vim.g.loaded_2html_plugin = 1
vim.g.loaded_bugreport = 1
vim.g.loaded_compiler = 1
vim.g.loaded_ftplugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_optwin = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_synmenu = 1
vim.g.loaded_syntax = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

--
-- autocmds
--

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "CursorHold", "CursorHoldI" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local bufnr = event.buf
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Handle nvim-treesitter updates",
  group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
  callback = function(event)
    if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
      vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, "TSUpdate")
      if ok then
        vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
      else
        vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
      end
    end
  end,
})

--
-- keymaps
--
--- Map a key combination to a command
---@param modes string|string[]: The mode(s) to map the key combination to
---@param lhs string: The key combination to map
---@param rhs string|function: The command to run when the key combination is pressed
---@param opts table: Options to pass to the keymap
local map = function(modes, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

-- commands with ;
map("n", ";", ":", {
  noremap = true,
  expr = true,
  callback = function()
    vim.fn.feedkeys(":", "n")
    return ""
  end,
})

-- save buffer
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "save file" })

-- center buffer on jumps
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "go to right window", remap = true })

-- Resize windows
map("n", "<C-Up>", "<C-w>+", { desc = "increase window height" })
map("n", "<C-Down>", "<C-w>-", { desc = "decrease window height" })
map("n", "<C-Left>", "<C-w><", { desc = "decrease window width" })
map("n", "<C-Right>", "<C-w>>", { desc = "increase window width" })

-- better indenting
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

map("n", "<leader>iw", "<cmd>Inspect<CR>", { desc = "inspect word", remap = true })
map("n", "<leader>it", "<cmd>InspectTree<CR>", { desc = "inspect tree", remap = true })

-- smart dd
-- don't replace yank register if deleting empty line in NORMAL MODE
local function smart_dd_normal()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end
map("n", "dd", smart_dd_normal, { noremap = true, expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })

-- jump
map("n", "*", "*N", { silent = true }) -- do not jump forward

-- windows
map("n", "<leader>w", "<c-w>", { desc = "windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "split window below", remap = true })
map("n", "<leader>\\", "<C-W>v", { desc = "split window right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "delete window", remap = true })

map("n", "<leader>wt", ":tabnew<CR>", { desc = "new tab" })
map("n", "[t", ":tabprev<cr>", { desc = "prev tab" })
map("n", "]t", ":tabnext<cr>", { desc = "next tab" })

map("n", "<leader>ch", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle inlay hints" })

map("n", "<leader>tR", "<cmd>OverseerRestartLast<Cr>", { desc = "restart last task" })

--
-- plugins
--

local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  vim.pack.del(unused_plugins)
end

map("n", "<leader>pu", function()
  vim.pack.update()
end, { desc = "update" })

map("n", "<leader>pc", pack_clean, { desc = "clean" })

-- snacks
require("snacks").setup({
  bigfile = {
    enabled = true,
    size = 4 * 1024 * 1024,
  },
  bufdelete = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  terminal = {},
})

map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "delete buffer" })

map("n", "<leader>go", function()
  Snacks.gitbrowse()
end, { desc = "open browser" })

-- mini.misc
local misc = require("mini.misc")
misc.setup()
misc.setup_restore_cursor()

-- mini.clue
local clue = require("mini.clue")

local miniclue_clues = {}
local function append(mode, keys, desc)
  table.insert(miniclue_clues, { mode = mode, keys = keys, desc = desc })
end

local leader_groups = {
  { suffix = "a", desc = "ai" },
  { suffix = "b", desc = "buffer" },
  { suffix = "c", desc = "code" },
  { suffix = "d", desc = "diagnostics" },
  { suffix = "f", desc = "find" },
  { suffix = "g", desc = "git" },
  { suffix = "i", desc = "inspect" },
  { suffix = "m", desc = "marks" },
  { suffix = "p", desc = "plugins" },
  { suffix = "q", desc = "quit / session" },
  { suffix = "s", desc = "search" },
  { suffix = "t", desc = "test / tasks" },
  { suffix = "w", desc = "window / tab" },
}

for _, mode in ipairs({ "n", "x" }) do
  for _, group in ipairs(leader_groups) do
    append(mode, "<leader>" .. group.suffix, group.desc)
  end
  append(mode, "[", "prev")
  append(mode, "]", "next")
end

clue.setup({
  triggers = {
    { mode = "n", keys = "<leader>" },
    { mode = "x", keys = "<leader>" },
    { mode = "n", keys = "[" },
    { mode = "x", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "x", keys = "]" },
  },
  clues = miniclue_clues,
  window = {
    delay = 200,
  },
})

map("n", "<leader>?", function()
  local clue = require("mini.clue")
  clue.ensure_buf_triggers()
  vim.schedule(function()
    vim.api.nvim_input("<leader>")
  end)
end, { desc = "show <leader> clues" })

-- mini.ai
require("mini.ai").setup()

-- mini.files
require("mini.files").setup({
  mappings = {
    go_in_plus = "<CR>",
    go_out = "-",
  },
  windows = {
    preview = true,
    width_preview = 50,
  },
})

-- mini.jump
require("mini.jump").setup({
  mappings = {
    forward = "f",
    backward = "F",
    forward_till = "t",
    backward_till = "T",
    repeat_jump = ",",
  },
})

-- mini.move
require("mini.move").setup()

-- mini.surround
require("mini.surround").setup()

-- mini.statusline
require("mini.statusline").setup()

map("n", "-", function()
  if vim.fn.filereadable(vim.fn.bufname("%")) > 0 then
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  else
    MiniFiles.open()
  end
end, { desc = "explorer" })

map("n", "=", function()
  MiniFiles.open(MiniFiles.get_latest_path())
end, { desc = "explorer resume" })

-- fzf-lua
require("fzf-lua").setup({
  defaults = {
    git_icons = false,
    file_icons = false,
  },
  files = {
    path_shorten = 1,
  },
})

map("n", "<leader>,", function()
  require("fzf-lua").buffers()
end, { desc = "buffers" })

map("n", "<leader>/", function()
  require("fzf-lua").live_grep()
end, { desc = "grep" })

map("n", "<leader>;", function()
  require("fzf-lua").command_history()
end, { desc = "command history" })

map("n", "<leader><space>", function()
  require("fzf-lua").global()
end, { desc = "global finder" })

map("n", "<leader>fg", function()
  require("fzf-lua").git_files()
end, { desc = "find git files" })

map("n", "<leader>fr", function()
  require("fzf-lua").oldfiles()
end, { desc = "recent" })

map("n", "<leader>sB", function()
  require("fzf-lua").lgrep_curbuf()
end, { desc = "grep open buffers" })

map({ "n", "x" }, "<leader>sw", function()
  require("fzf-lua").grep_cword()
end, { desc = "visual selection or word" })

map("n", "<leader>sC", function()
  require("fzf-lua").commands()
end, { desc = "commands" })

map("n", "<leader>sd", function()
  require("fzf-lua").diagnostics_workspace()
end, { desc = "diagnostics" })

map("n", "<leader>sh", function()
  require("fzf-lua").help_tags()
end, { desc = "help pages" })

map("n", "<leader>sj", function()
  require("fzf-lua").jumps()
end, { desc = "jumps" })

map("n", "<leader>sk", function()
  require("fzf-lua").keymaps()
end, { desc = "keymaps" })

map("n", "<leader>sl", function()
  require("fzf-lua").loclist()
end, { desc = "location list" })

map("n", "<leader>sm", function()
  require("fzf-lua").marks()
end, { desc = "marks" })

map("n", "<leader>r", function()
  require("fzf-lua").resume()
end, { desc = "resume" })

map("n", "<leader>sq", function()
  require("fzf-lua").quickfix()
end, { desc = "quickfix list" })

map("n", "<leader>qp", function()
  require("fzf-lua").git_branches()
end, { desc = "branches" })

map("n", "gd", function()
  require("fzf-lua").lsp_definitions()
end, { desc = "goto definition" })

map("n", "gD", function()
  require("fzf-lua").lsp_declarations()
end, { desc = "goto declaration" })

map("n", "gr", function()
  require("fzf-lua").lsp_references()
end, { nowait = true, desc = "references" })

map("n", "gI", function()
  require("fzf-lua").lsp_implementations()
end, { desc = "goto implementation" })

map("n", "gy", function()
  require("fzf-lua").lsp_typedefs()
end, { desc = "goto type definition" })

map("n", "gs", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "lsp symbols" })

map("n", "gS", function()
  require("fzf-lua").lsp_workspace_symbols()
end, { desc = "lsp workspace symbols" })

map("n", "<leader>gl", function()
  require("fzf-lua").git_commits()
end, { desc = "git log" })

map("n", "<leader>gd", function()
  require("fzf-lua").git_bcommits()
end, { desc = "git diff" })

map("n", "<leader>gB", function()
  require("fzf-lua").git_branches()
end, { desc = "branches" })

-- neogit
map("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "git" })

-- better-escape
require("better_escape").setup({
  mappings = {
    i = { k = { j = "<Esc>" } },
  },
})

-- conform
require("conform").setup({
  formatters_by_ft = {
    ["*"] = { "codespell", "typos" },
    ["terraform-vars"] = { "terraform_fmt" },
    bash = { "shfmt" },
    css = { "prettierd", "prettier", stop_after_first = true },
    elixir = { "mix" },
    go = { "gofmt" },
    html = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    terraform = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    toml = { "taplo" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    zsh = { "shfmt" },
  },
  formatters = {
    injected = {
      ignore_errors = true,
    },
  },
  default_format_opts = {
    timeout_ms = 3000,
    lsp_format = "fallback",
  },
  format_on_save = nil,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

map("", "<leader>bf", function()
  require("conform").format({ async = true })
end, { desc = "format buffer" })

-- dial
local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
    augend.semver.alias.semver,
    augend.case.new({
      types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
    }),
    augend.constant.new({
      elements = { "let", "const" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "and", "or" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "on", "off" },
      word = false,
      cyclic = true,
    }),
  },
})

map("n", "<C-a>", function()
  return require("dial.map").inc_normal()
end, { expr = true })

map("n", "<C-x>", function()
  return require("dial.map").dec_normal()
end, { expr = true })

-- treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "css",
    "diff",
    "eex",
    "elixir",
    "erlang",
    "heex",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "regex",
    "rust",
    "svelte",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<C-CR>",
    },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {},
      selection_modes = {},
      include_surrounding_whitespace = true,
    },
  },
})

map("n", "<CR>", "", { desc = "increment selection" })
map("x", "<C-CR>", "", { desc = "decrement selection" })

-- gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = function(buffer)
    local gs = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "next hunk")
    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "prev hunk")

    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "stage hunk")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "reset hunk")
    map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
    map("n", "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
    map("n", "<leader>gR", gs.reset_buffer, "reset buffer")
    map("n", "<leader>gp", gs.preview_hunk_inline, "preview hunk inline")
    map("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, "blame line")
    map("n", "<leader>gB", function()
      gs.blame()
    end, "blame buffer")
    map("n", "<leader>gd", gs.diffthis, "diff")
  end,
})

-- grug-far
require("grug-far").setup({ headerMaxWidth = 80 })

map({ "n", "v" }, "<leader>sr", function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "search and replace" })

-- undotree
map("n", "<leader>cu", "<cmd>UndotreeToggle<CR>", { desc = "undo tree" })

-- numb
require("numb").setup({
  show_numbers = true,
  show_cursorline = true,
})

-- relative-toggle
require("relative-toggle").setup()

-- lsp
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "Snacks",
          "MiniFiles",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("elixirls", {
  cmd = { "elixir-ls" },
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
      enableTestLenses = false,
    },
  },
})

vim.lsp.config("tailwindcss", {})

vim.lsp.config("copilot", {
  settings = {
    telemetry = {
      telemetryLevel = "off",
    },
  },
})

for _, language_server in ipairs({
  "copilot",
  "elixirls",
  "html",
  "lua_ls",
  "yamlls",
  "rust_analyzer",
  "terraformls",
  "gopls",
  "tailwindcss",
}) do
  vim.lsp.enable(language_server)
end

vim.lsp.inline_completion.enable()

-- other
require("other-nvim").setup({
  showMissingFiles = true,
  mappings = {
    "elixir",
    "rust",
  },
})

map("n", "ga", "<Cmd>:Other<CR>", { desc = "open alternative file" })
map("n", "gA", "<Cmd>:OtherSplit<CR>", { desc = "open alternative file in split" })

-- blink
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-o>"] = { "accept", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = {
      "snippet_forward",
      function()
        return require("sidekick").nes_jump_or_apply()
      end,
      function()
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
  },
  cmdline = { sources = { "cmdline" } },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- toggleterm
require("toggleterm").setup({
  insert_mappings = true,
  terminal_mappings = true,
  direction = "vertical",
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
})

-- vim-test
vim.g["test#echo_command"] = 1
vim.g["test#strategy"] = "toggleterm"

vim.g["test#rust#cargotest#options"] = {
  nearest = "-- --nocapture",
}

map("n", "<leader>ts", "<cmd>TestSuite<CR>", { desc = "test suite" })
map("n", "<leader>tf", "<cmd>TestFile<CR>", { desc = "test file" })
map("n", "<leader>tn", "<cmd>TestNearest<CR>", { desc = "test nearest" })
map("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "test last" })

-- overseer
require("overseer").setup({
  dap = false,
  task_list = {
    bindings = {
      ["<C-h>"] = false,
      ["<C-j>"] = false,
      ["<C-k>"] = false,
      ["<C-l>"] = false,
    },
  },
  form = {
    win_opts = {
      winblend = 0,
    },
  },
  confirm = {
    win_opts = {
      winblend = 0,
    },
  },
  task_win = {
    win_opts = {
      winblend = 0,
    },
  },
})

local overseer = require("overseer")
overseer.register_template({
  name = "mix docs",
  builder = function()
    return {
      cmd = { "mix", "docs" },
      components = {
        "default",
      },
      cwd = vim.fn.getcwd(),
    }
  end,
  desc = "mix docs",
})

map("n", "<leader>tr", "<cmd>OverseerRun<CR>", { desc = "run task" })
map("n", "<leader>tt", "<cmd>OverseerToggle<CR>", { desc = "task list" })
map("n", "<leader>tb", "<cmd>OverseerBuild<CR>", { desc = "build task" })
map("n", "<leader>ta", "<cmd>OverseerTaskAction<CR>", { desc = "task action" })
map("n", "<leader>tq", "<cmd>OverseerQuickAction<CR>", { desc = "recent task" })

-- tiny-inline-diagnostic
vim.diagnostic.config({ virtual_text = false })
require("tiny-inline-diagnostic").setup()

-- trouble
require("trouble").setup({})

map("n", "<leader>dw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "workspace" })
map("n", "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "buffer" })

-- flash
require("flash").setup({})

-- sidekick
require("sidekick").setup({})

map("n", "<leader>aa", function()
  require("sidekick.cli").toggle()
end, { desc = "toggle" })

map("n", "<leader>ac", function()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "claude" })

map({ "n", "v" }, "<leader>as", function()
  require("sidekick.cli").send()
end, { desc = "send visual selection" })

map("n", "<leader>ap", function()
  require("sidekick.cli").select_prompt()
end, { desc = "select prompt" })

map({ "i", "t" }, "<c-.>", function()
  require("sidekick.cli").switch_focus()
end, { desc = "switch focus" })

map({ "i", "n" }, "<Tab>", function()
  if require("sidekick").nes_jump_or_apply() then
    return
  end

  if vim.lsp.inline_completion.get() then
    return
  end

  return "<Tab>"
end, { expr = true, desc = "goto / apply suggestion" })
