-- commands with ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- save buffer
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- center buffer on jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- better jk
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- smart dd
-- don't replace yank register if deleting empty line in NORMAL MODE
local function smart_dd_normal()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end
vim.keymap.set("n", "dd", smart_dd_normal, { noremap = true, expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- smart-splits.nvim
local ss = require("smart-splits")
vim.keymap.set("n", "<A-h>", ss.resize_left)
vim.keymap.set("n", "<A-j>", ss.resize_down)
vim.keymap.set("n", "<A-k>", ss.resize_up)
vim.keymap.set("n", "<A-l>", ss.resize_right)

-- navigation
-- tabs
vim.keymap.set("n", "]t", "<cmd>tabn<cr>", { noremap = true, desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabp<cr>", { noremap = true, desc = "Prev tab" })
-- marks (harpoon)
vim.keymap.set("n", "<Tab>", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { noremap = true, desc = "Next mark" })
vim.keymap.set("n", "<S-Tab>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { noremap = true, desc = "Prev mark" })
-- kitty integration
vim.keymap.set("n", "<C-h>", "<cmd>KittyNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>KittyNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>KittyNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>KittyNavigateRight<cr>")
-- jump
vim.keymap.set("n", "n", "nzzzv") -- center screen
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*N") -- do not jump forward

-- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- context
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

-- git chuncks
vim.keymap.set(
  "n",
  "]g",
  "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
  { desc = "Next git hunk" }
)
vim.keymap.set(
  "n",
  "[g",
  "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
  { desc = "Prev git hunk" }
)

local present, wk = pcall(require, "which-key")

if not present then
  return
end

local options = {
  key_labels = { ["<leader>"] = "SPC" },
  layout = {
    spacing = 6,
  },
}

wk.setup(options)

local mapping_opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local is_inside_work_tree = {}
local function project_files()
  local builtin = require("telescope.builtin")
  local opts = {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

local mappings = {
  [";"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
  [","] = { "<cmd>Telescope buffers<cr>", "Buffers" },
  m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Marked Files" },
  ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Marked file 1" },
  ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Marked file 2" },
  ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Marked file 3" },
  ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Marked file 4" },
  ["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Marked file 5" },
  b = {
    name = "Buffer",
    -- f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
    t = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble" },
  },
  c = { "<cmd>BufDel<CR>", "Close Buffer" },
  e = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
  f = { project_files, "Find File" },
  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "Lazygit" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },
  n = {
    name = "Navigate",
    m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File" },
    t = { "<cmd>$tabnew<cr>", "New tab" },
    c = { "<cmd>tabclose<cr>", "Close tab" },
    h = { "<cmd>-tabmove<cr>", "Move tab left" },
    l = { "<cmd>+tabmove<cr>", "Move tab right" },
  },
  o = {
    name = "Tools",
    o = { "<cmd>OutputPanel<cr>", "OutputPanel" },
    l = { "<cmd>Lazy<cr>", "Lazy" },
    m = { "<cmd>Mason<cr>", "Mason" },
    M = { "<cmd>MasonLog<cr>", "MasonLog" },
    n = { "<cmd>NullLsInstall<cr>", "NullLsInstall" },
    N = { "<cmd>NullLsInfo<cr>", "NullLsInfo" },
    s = { "<cmd>LspInstall<cr>", "LspInstall" },
    S = { "<cmd>LspInfo<cr>", "LspInfo" },
  },
  p = {
    name = "Project",
    o = { "<cmd>Telescope projects<cr>", "Open" },
    t = { "<cmd>TodoTelescope<cr>", "Todo List" },
  },
  r = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume Search" },
  s = {
    name = "Search",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    w = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Current Word" },
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    R = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Current word" },
  },
  t = { name = "Test" },
  u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
  w = {
    name = "Windows",
    j = { "<cmd>split<cr>", "Split Down" },
    l = { "<cmd>vsp<cr>", "Split Right" },
    z = { "<cmd>lua require('maximize').toggle()<cr>", "Zoom" },
  },
  y = { "<cmd>:lua require('telescope').extensions.yank_history.yank_history()<cr>", "Yank history" },
}

wk.register(mappings, mapping_opts)
