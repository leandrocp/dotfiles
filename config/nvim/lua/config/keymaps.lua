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

-- tabs
vim.keymap.set("n", "<leader>wt", "<cmd>$tabnew<cr>", { noremap = true, desc = "New tab" })
vim.keymap.set("n", "<leader>wc", "<cmd>tabclose<cr>", { noremap = true, desc = "Close tab" })
vim.keymap.set("n", "]t", "<cmd>tabn<cr>", { noremap = true, desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabp<cr>", { noremap = true, desc = "Prev tab" })

-- jump
vim.keymap.set("n", "n", "nzzzv") -- center screen
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*N") -- do not jump forward

-- windows
vim.keymap.set("n", "<leader>wj", "<cmd>split<cr>", { desc = "Split down" })
vim.keymap.set("n", "<leader>wl", "<cmd>vsp<cr>", { desc = "Split right" })

-- buffers
map("n", "<leader>bd", function()
  snacks.bufdelete({ wipe = true })
end, { desc = "Delete" })

-- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- tools
vim.keymap.set("n", "<leader>ol", "<cmd>Lazy<cr>", { desc = "Lazy" })
