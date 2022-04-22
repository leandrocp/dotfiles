-- ********
-- Settings
-- ********
-- vim.opt.timeoutlen = 500
-- vim.opt.lazyredraw = true
vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarkpro"
lvim.leader = "space"
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.theme = "onedarkpro"
lvim.builtin.lualine.sections.lualine_b = {
	"branch",
	{
		"filename",
		file_status = true,
		path = 1,
		shorting_target = 40,
	},
	"location",
}
lvim.builtin.lualine.sections.lualine_c = { "diff" }
lvim.lsp.automatic_servers_installation = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shade_terminals = false
lvim.builtin.terminal.shading_factor = 3
lvim.builtin.terminal.persist_size = true
lvim.builtin.terminal.direction = "horizontal"
-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "iex", "xi", "iex" }
lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
lvim.builtin.telescope.on_config_done = function()
	local telescope = require("telescope")
	telescope.load_extension("fzf")
end
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"json",
	"lua",
	"html",
	"css",
	"javascript",
	"erlang",
	"elixir",
	"eex",
	"heex",
	-- "rust",
	"toml",
	"yaml",
	"dockerfile",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.project.silent_chdir = false

-- ***********
-- Keybindings
-- ***********
local keymap = vim.api.nvim_set_keymap

keymap("n", ";", ":", { noremap = true })

lvim.keys.normal_mode = {
	["<C-s>"] = ":w<cr>",
	["<Tab>"] = ":bnext<CR>",
	["<S-Tab>"] = ":bprevious<CR>",
}

lvim.builtin.which_key.mappings["w"] = {
	name = "Window",
	j = { "<cmd>split<cr>", "Split Down" },
	l = { "<cmd>vsp<cr>", "Split Right" },
	w = { "<cmd>InteractiveWindow<cr>", "Interactive" },
	p = { "<cmd>BufferLinePick<cr>", "Pick" },
}

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	l = { "<cmd>TestLast<cr>", "Last" },
	n = { "<cmd>TestNearest<cr>", "Nearest" },
	f = { "<cmd>TestFile<cr>", "File" },
	s = { "<cmd>TestSuite<cr>", "Suite" },
	v = { "<cmd>TestVisit<cr>", "Visit" },
}

lvim.builtin.which_key.mappings["ss"] = {
	"<cmd>lua require('telescope.builtin').resume()<cr>",
	"Resume",
}

lvim.builtin.which_key.mappings["sw"] = {
	"<cmd>lua require('telescope.builtin').grep_string()<cr>",
	"Current Word",
}

lvim.builtin.which_key.mappings["sg"] = {
	name = "Replace",
	o = { "<cmd>lua require('spectre').open()<cr>", "Open" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Current word" },
}

lvim.builtin.which_key.mappings["e"] = {
	name = "Explorer",
	t = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
	f = { "<cmd>NvimTreeFindFile<cr>", "Find file" },
	r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
	s = { "<cmd>SymbolsOutline<cr>", "Symbols" },
}

-- lvim.builtin.which_key.mappings["x"] = {
-- 	name = "Execute",
-- 	m = {
-- 		name = "mix",
-- 		c = { "<cmd>Tmux mix compile --all-warnings<cr>", "compile" },
-- 		s = { "<cmd>Tmux iex -S mix phx.server<cr>", "phx.server" },
-- 		d = { "<cmd>Tmux mix dialyzer<cr>", "dialyzer" },
-- 		l = { "<cmd>Tmux mix credo --strict<cr>", "credo" },
-- 		q = { "<cmd>Tmux quality<cr>", "quality" },
-- 		f = { "<cmd>Tmux mix format<cr>", "format" },
-- 	},
-- }

-- *********
-- Languages
-- *********
local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "rustfmt", filetypes = { "rust", "rs" } },
})

-- ***********
-- Keybindings
-- ***********
lvim.plugins = {
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			local theme = require("onedarkpro")
			theme.load()
			theme.setup({
				options = {
					terminal_colors = true,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	},
	-- { "tpope/vim-repeat" },
	-- {
	-- 	"nathom/filetype.nvim",
	-- 	config = function()
	-- 		require("filetype").setup({
	-- 			overrides = {
	-- 				extensions = {
	-- 					exs = "elixir",
	-- 					leex = "eelixir",
	-- 					heex = "eelixir",
	-- 				},
	-- 				literal = {
	-- 					["mix.lock"] = "elixir",
	-- 				},
	-- 			},
	-- 		})

	-- 		vim.g.did_load_filetypes = 1
	-- 	end,
	-- },
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true,
				show_cursorline = true,
			})
		end,
	},
	{ "romainl/vim-cool" },
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"vim-test/vim-test",
		config = function()
			vim.cmd([[
    let g:test#preserve_screen = 1
    let test#strategy = "kitty"
    ]])
		end,
	},
	{
		"knubie/vim-kitty-navigator",
		run = "cp *.py ~/.config/kitty/"
	},
	-- {
	-- 	"max397574/better-escape.nvim",
	-- 	config = function()
	-- 		require("better_escape").setup({
	-- 			mapping = { "kj" },
	-- 		})
	-- 	end,
	-- },
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			local plugin = require("smart-splits")
			vim.keymap.set("n", "<A-h>", plugin.resize_left)
			vim.keymap.set("n", "<A-j>", plugin.resize_down)
			vim.keymap.set("n", "<A-k>", plugin.resize_up)
			vim.keymap.set("n", "<A-l>", plugin.resize_right)
			vim.keymap.set("n", "<C-h>", plugin.move_cursor_left)
			vim.keymap.set("n", "<C-j>", plugin.move_cursor_down)
			vim.keymap.set("n", "<C-k>", plugin.move_cursor_up)
			vim.keymap.set("n", "<C-l>", plugin.move_cursor_right)
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			vim.g.symbols_outline = {
				auto_preview = false,
			}
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"tpope/vim-projectionist",
		config = function()
			vim.cmd([[
let g:projectionist_heuristics = {
  \ "mix.exs": {
    \ 'apps/*/mix.exs': { 'type': 'app' },
    \ 'lib/*.ex': {
    \   'type': 'source',
    \   'alternate': 'test/{}_test.exs',
    \   'template': [
    \     'defmodule {camelcase|capitalize|dot} do',
    \     'end'
    \   ],
    \ },
    \ 'test/*_test.exs': {
    \   'type': 'test',
    \   'alternate': 'lib/{}.ex',
    \   'template': [
    \     'defmodule {camelcase|capitalize|dot}Test do',
    \     '  use ExUnit.Case, async: true',
    \     '',
    \     '  alias {camelcase|capitalize|dot}',
    \     '',
    \     'end'
    \   ],
    \ },
    \ 'lib/**/controllers/*_controller.ex': {
    \   'type': 'controller',
    \   'alternate': 'test/{dirname}/controllers/{basename}_controller_test.exs',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Controller do',
    \     '  use {dirname|camelcase|capitalize}, :controller',
    \     'end'
    \   ],
    \ },
    \ 'test/**/controllers/*_controller_test.exs': {
    \   'alternate': 'lib/{dirname}/controllers/{basename}_controller.ex',
    \   'type': 'test',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ControllerTest do',
    \     '  use {dirname|camelcase|capitalize}.ConnCase, async: true',
    \     'end'
    \   ]
    \ },
    \ 'lib/**/live/*_live.ex': {
    \   'type': 'live',
    \   'alternate': 'test/{dirname}/live/{basename}_live_test.exs',
    \   'related': [
    \     '{dirname|dirname}/views/{basename}_view.ex'
    \   ],
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Live do',
    \     '  use {dirname|camelcase|capitalize}, :live_view',
    \     '',
    \     '  def mount(_params, _session, socket) do',
    \     '    if connected?(socket), do: :ok',
    \     '',
    \     '    {:ok, socket |> assign(:page_title, "Foo")}',
    \     '  end',
    \     '',
    \     '  def render(assigns) do',
    \     '    {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View.render("foo.html", assigns)',
    \     '  end',
    \     'end'
    \   ]
    \ },
    \ '*eex': {
    \   'type': 'template',
    \   'related': [
    \     '{dirname|dirname|dirname}/controllers/{dirname|basename}_controller.ex',
    \     '{dirname|dirname|dirname}/live/{dirname|basename}_live.ex',
    \     '{dirname|dirname|dirname}/views/{dirname|basename}_view.ex'
    \   ]
    \ },
    \ 'lib/**/views/*_view.ex': {
    \   'type': 'view',
    \   'alternate': 'test/{dirname}/views/{basename}_view_test.exs',
    \   'related': [
    \     '{dirname|dirname}/live/{basename}_live.ex',
    \     '{dirname|dirname}/controllers/{basename}_controller.ex'
    \   ],
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View do',
    \     '  use {dirname|camelcase|capitalize}, :view',
    \     'end'
    \   ]
    \ },
    \ 'test/**/views/*_view_test.exs': {
    \   'alternate': 'lib/{dirname}/views/{basename}_view.ex',
    \   'type': 'test',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ViewTest do',
    \     '  use ExUnit.Case, async: true',
    \     '',
    \     '  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View',
    \     'end'
    \   ]
    \ },
    \ 'mix.exs': { 'type': 'mix' },
    \ 'config/*.exs': { 'type': 'config' },
    \ '*.ex': {
    \   'makery': {
    \     'lint': { 'compiler': 'credo' },
    \     'test': { 'compiler': 'exunit' },
    \     'build': { 'compiler': 'mix' }
    \   }
    \ },
    \ '*.exs': {
    \   'makery': {
    \     'lint': { 'compiler': 'credo' },
    \     'test': { 'compiler': 'exunit' },
    \     'build': { 'compiler': 'mix' }
    \   }
    \ }
   \ }
  \ }
  ]])
		end,
	},
}
