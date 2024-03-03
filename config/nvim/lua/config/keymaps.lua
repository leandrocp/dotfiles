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
vim.keymap.set("n", "<leader>wt", "<cmd>$tabnew<cr>", { noremap = true, desc = "New tab" })
vim.keymap.set("n", "<leader>wc", "<cmd>tabclose<cr>", { noremap = true, desc = "Close tab" })
vim.keymap.set("n", "]t", "<cmd>tabn<cr>", { noremap = true, desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabp<cr>", { noremap = true, desc = "Prev tab" })

--     t = { "<cmd>$tabnew<cr>", "New tab" },
--     c = { "<cmd>tabclose<cr>", "Close tab" },
--     h = { "<cmd>-tabmove<cr>", "Move tab left" },
--     l = { "<cmd>+tabmove<cr>", "Move tab right" },
--
-- kitty integration
vim.keymap.set("n", "<C-h>", "<cmd>KittyNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>KittyNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>KittyNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>KittyNavigateRight<cr>")
-- jump
vim.keymap.set("n", "n", "nzzzv") -- center screen
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*N") -- do not jump forward
-- windows
vim.keymap.set("n", "<leader>wj", "<cmd>split<cr>", { desc = "Split down" })
vim.keymap.set("n", "<leader>wl", "<cmd>vsp<cr>", { desc = "Split right" })

-- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- tools
vim.keymap.set("n", "<leader>ol", "<cmd>Lazy<cr>", { desc = "Lazy" })
