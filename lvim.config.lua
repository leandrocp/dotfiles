-- ********
-- Settings
-- ********
vim.opt.timeoutlen = 500
vim.opt.lazyredraw = true
vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.leader = "space"
lvim.builtin.telescope.defaults.path_display.shorten = nil
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
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
	"rust",
	"toml",
	"yaml",
	"dockerfile",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.terminal.direction = "horizontal"
-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "iex", "xi", "iex" }

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

lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	l = { "<cmd>TestLast<cr>", "Last" },
	n = { "<cmd>TestNearest<cr>", "Nearest" },
	f = { "<cmd>TestFile<cr>", "File" },
	s = { "<cmd>TestSuite<cr>", "Suite" },
	v = { "<cmd>TestVisit<cr>", "Visit" },
}

lvim.builtin.which_key.mappings["ss"] = {
	"cmd>lua require('telescope.builtin').resume()<cr>",
	"Resume",
}

lvim.builtin.which_key.mappings["su"] = {
	"<cmd>lua require('telescope.builtin').grep_string()<cr>",
	"Search under cursor",
}

lvim.builtin.which_key.mappings["sr"] = {
	name = "Replace",
	t = { "<cmd>lua require('spectre').open()<cr>", "Open" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Current word" },
}

lvim.builtin.which_key.mappings["e"] = {
	name = "Explorer",
	t = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
	f = { "<cmd>NvimTreeFindFile<cr>", "Find file" },
	r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
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

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.hcl = {
  filetype = "hcl", "terraform",
}

-- ***********
-- Keybindings
-- ***********
lvim.plugins = {
	{
		"navarasu/onedark.nvim",
		config = function()
			local theme = require("onedark")
			theme.load()
			theme.setup({
				style = "warm",
			})
		end,
	},
	{ "tpope/vim-repeat" },
	{
		"nathom/filetype.nvim",
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						exs = "elixir",
						leex = "eelixir",
						heex = "eelixir",
					},
					literal = {
						["mix.lock"] = "elixir",
					},
				},
			})

			vim.g.did_load_filetypes = 1
		end,
	},
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
    let test#strategy = "neovim"
    let g:test#preserve_screen = 1
    ]])
		end,
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
