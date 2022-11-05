vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
vim.opt.laststatus = 3
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

lvim.log.level = "warn"
lvim.leader = "space"
lvim.format_on_save.enabled = false
lvim.colorscheme = "onedarkpro"

lvim.builtin.breadcrumbs.active = false
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.theme = "onedarkpro"
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.sections.lualine_b = {
	"branch",
	{
		"filename",
		file_status = true,
		path = 1,
		shorting_target = 40,
	},
}
lvim.builtin.lualine.sections.lualine_c = {
	"location",
	"diff",
}

lvim.lsp.automatic_configuration = true
lvim.lsp.diagnostics.virtual_text = false

lvim.builtin.terminal.active = false

lvim.builtin.telescope.defaults = {
	path_display = { shorten = 10 },
	layout_strategy = "vertical",
	-- layout_config = {
	-- 	width = 0.9,
	-- },
	-- layout_config = {
	-- 	horizontal = {
	-- 		prompt_position = "top",
	-- 		preview_width = 0.55,
	-- 		results_width = 0.8,
	-- 	},
	-- 	vertical = {
	-- 		mirror = false,
	-- 	},
	-- 	width = 0.87,
	-- 	height = 0.80,
	-- 	preview_cutoff = 120,
	-- },
	pickers = {
		live_grep = {
			on_input_filter_cb = function(prompt)
				-- AND operator for live_grep like how fzf handles spaces with wildcards in rg
				-- https://www.reddit.com/r/neovim/comments/udx0fi/telescopebuiltinlive_grep_and_operator
				return { prompt = prompt:gsub("%s", ".*") }
			end,
		},
	},
}

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
	"toml",
	"yaml",
	"dockerfile",
	"python",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.project.silent_chdir = false

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

lvim.builtin.which_key.mappings["bd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics" }

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	l = { "<cmd>TestLast<cr>", "Last" },
	n = { "<cmd>TestNearest<cr>", "Nearest" },
	f = { "<cmd>TestFile<cr>", "File" },
	s = { "<cmd>TestSuite<cr>", "Suite" },
	v = { "<cmd>TestVisit<cr>", "Visit" },
}

lvim.builtin.which_key.mappings["ss"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume" }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Current Word" }

lvim.builtin.which_key.mappings["F"] = {
	name = "Find File",
	e = {
		"<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '-g', '*.{ex,exs}'}})<CR>",
		"Elixir",
	},
	t = {
		"<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '-g', '*.{html,eex,leex,heex}'}})<CR>",
		"Templates",
	},
}

lvim.builtin.which_key.mappings["S"] = {
	name = "Special Search",
	e = {
		"<cmd>lua require('telescope.builtin').live_grep({ additional_args = function() return {'-g*.{ex,exs}'} end })<CR>",
		"Elixir",
	},
	t = {
		"<cmd>lua require('telescope.builtin').live_grep({ additional_args = function() return {'-g*.{html,eex,leex,heex}'} end })<CR>",
		"Templates",
	},
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

local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "rustfmt", filetypes = { "rust", "rs" } },
})

lvim.plugins = {
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			local theme = require("onedarkpro")
			theme.load()
			theme.setup({
				dark_theme = "onedark_vivid",
				options = {
					terminal_colors = true,
				},
			})
		end,
	},
	{ "tpope/vim-repeat" },
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
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
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
		run = "cp *.py ~/.config/kitty/",
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
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
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

vim.cmd([[
" Better ESC
" https://www.reddit.com/r/vim/comments/ufgrl8/journey_to_the_ultimate_imap_jk_esc
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
	return (l:timediff <= 0.05 && l:timediff >=0.001) ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')
]])
