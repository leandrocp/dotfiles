local keymap = vim.api.nvim_set_keymap

keymap("n", ";", ":", { noremap = true })
keymap("n", "<C-s>", ":w<CR>", { noremap = true })
keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
keymap("n", "<Tab>", ":bnext<CR>", { noremap = true })
keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true })
keymap("n", "n", "nzzzv", { noremap = true })
keymap('n', 'N', 'Nzzzv', { noremap = true })

-- smart-splits.nvim
local ss =require("smart-splits")
vim.keymap.set('n', '<A-h>', ss.resize_left)
vim.keymap.set('n', '<A-j>', ss.resize_down)
vim.keymap.set('n', '<A-k>', ss.resize_up)
vim.keymap.set('n', '<A-l>', ss.resize_right)
vim.keymap.set('n', '<C-h>', ss.move_cursor_left)
vim.keymap.set('n', '<C-j>', ss.move_cursor_down)
vim.keymap.set('n', '<C-k>', ss.move_cursor_up)
vim.keymap.set('n', '<C-l>', ss.move_cursor_right)

local present, wk = pcall(require, "which-key")

if not present then
  return
end

local options = {
  icons = {
    breadcrumb = "»",
    separator = "  ",
    group = "+",
  },

  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },

  window = {
    border = "none",
  },

  layout = {
    spacing = 6,
  },

  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
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

local mappings = {
  -- ["w"] = { "<cmd>w!<CR>", "Save" },
  c = { "<cmd>BufDel<CR>", "Close Buffer" },

  f = { "<cmd>Telescope find_files<cr>", "Find File" },

  s = {
    name = "Search",
    s = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    w = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Current Word" },
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    R = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Current word" },
  },

  b = {
    name = "Buffer",
    f = { "<cmd>LspZeroFormat<cr>", "Format" }
  },

  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
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
    t = { "<cmd>NvimTreeToggle<cr>", "Tree" },
    f = { "<cmd>NvimTreeFindFile<cr>", "Tree File" },
    m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
  },

  t = {
    name = "Test",
    l = { "<cmd>TestLast<cr>", "Last" },
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    f = { "<cmd>TestFile<cr>", "File" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
  },

  p = {
    name = "Packer",
    s = { "<cmd>PackerSync<cr>", "Sync" }
  },

  w = {
    name = "Window",
    j = { "<cmd>split<cr>", "Split Down" },
    l = { "<cmd>vsp<cr>", "Split Right" },
    w = { "<cmd>InteractiveWindow<cr>", "Interactive" },
    p = { "<cmd>BufferLinePick<cr>", "Pick" },
  }
}

wk.register(mappings, mapping_opts)
