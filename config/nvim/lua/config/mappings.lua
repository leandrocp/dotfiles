-- commands with ;
vim.keymap.set("n", ";", ":", { noremap = true })

-- save buffer
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")

-- center buffer on jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

-- navigate with tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true })

-- better JK
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- smart-splits.nvim
local ss = require("smart-splits")
vim.keymap.set('n', '<A-h>', ss.resize_left)
vim.keymap.set('n', '<A-j>', ss.resize_down)
vim.keymap.set('n', '<A-k>', ss.resize_up)
vim.keymap.set('n', '<A-l>', ss.resize_right)
vim.keymap.set('n', '<C-h>', "<cmd>KittyNavigateLeft<cr>")
vim.keymap.set('n', '<C-j>', "<cmd>KittyNavigateDown<cr>")
vim.keymap.set('n', '<C-k>', "<cmd>KittyNavigateUp<cr>")
vim.keymap.set('n', '<C-l>', "<cmd>KittyNavigateRight<cr>")

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

local function project_files()
  local opts = {}
  if vim.loop.fs_stat(".git") then
    opts.show_untracked = true
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

local mappings = {
  c = { "<cmd>BufDel<CR>", "Close Buffer" },

  ["<space>"] = { project_files, "Find File" },

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
    f = { "<cmd>LspZeroFormat<cr>", "Format" },
    u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
    s = { "<cmd>AerialToggle<cr>", "Symbols" }
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
    -- l = { "<cmd>TestLast<cr>", "Last" },
    -- n = { "<cmd>TestNearest<cr>", "Nearest" },
    -- f = { "<cmd>TestFile<cr>", "File" },
    -- s = { "<cmd>TestSuite<cr>", "Suite" },
    a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>", "File" },
    n = { "<cmd>lua require('neotest').run.run()<cr>", "Nearest" },
    s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
    p = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Panel" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
  },

  u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },

  p = {
    name = "Plugins",
    l = { "<cmd>Lazy<cr>", "Manage" }
  },

  w = {
    name = "Windows",
    j = { "<cmd>split<cr>", "Split Down" },
    l = { "<cmd>vsp<cr>", "Split Right" },
    m = { "<cmd>WindowsMaximize<cr>", "Maximize" },
    e = { "<cmd>WindowsEqualize<cr>", "Equalize" },
  }
}

wk.register(mappings, mapping_opts)
