local snacks = require("snacks")

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
map("n", ";", ":", { noremap = true })

-- save buffer
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- center buffer on jumps
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- better jk
map("n", "J", "mzJ`z", { silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- better indenting
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

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
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- smart-splits.nvim
local ss = require("smart-splits")
map("n", "<A-h>", ss.resize_left, { desc = "Resize left" })
map("n", "<A-j>", ss.resize_down, { desc = "Resize down" })
map("n", "<A-k>", ss.resize_up, { desc = "Resize up" })
map("n", "<A-l>", ss.resize_right, { desc = "Resize right" })

-- tabs
map("n", "<leader>wt", "<cmd>$tabnew<cr>", { noremap = true, desc = "New tab" })
map("n", "<leader>wc", "<cmd>tabclose<cr>", { noremap = true, desc = "Close tab" })
map("n", "]t", "<cmd>tabn<cr>", { noremap = true, desc = "Next tab" })
map("n", "[t", "<cmd>tabp<cr>", { noremap = true, desc = "Prev tab" })

-- jump
map("n", "n", "nzzzv", { silent = true }) -- center screen
map("n", "N", "Nzzzv", { silent = true })
map("n", "*", "*N", { silent = true }) -- do not jump forward

-- windows
map("n", "<leader>wj", "<cmd>split<cr>", { desc = "Split down" })
map("n", "<leader>wl", "<cmd>vsp<cr>", { desc = "Split right" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "switch other" })
map("n", "<leader>bd", function()
  snacks.bufdelete({ wipe = true })
end, { desc = "delete" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "delete others" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "next buffer" })

-- diagnostics

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- tools
map("n", "<leader>ol", "<cmd>Lazy<cr>", { desc = "Lazy" })
