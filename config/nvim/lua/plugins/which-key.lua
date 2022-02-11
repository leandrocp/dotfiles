local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local setup = {
		window = {
			border = "rounded",
		},
	}

	local opts = {
		prefix = "<leader>",
	}

	local mappings = {
		["v"] = { "<cmd>w!<CR>", "save" },
		["b"] = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"buffers",
		},
		["c"] = { "<cmd>Bdelete!<CR>", "close buffer" },
		["h"] = { "<cmd>nohlsearch<CR>", "no hl" },
		["f"] = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"find files",
		},

		["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "tab 1" },
		["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "tab 2" },
		["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "tab 3" },
		["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "tab 4" },
		["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "tab 5" },
		["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "tab 6" },
		["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "tab 7" },
		["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "tab 8" },
		["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "tab 9" },

		-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

		e = {
			name = "execute",
			m = {
				name = "mix",
				c = { "<cmd>Tmux mix compile --all-warnings<cr>", "compile" },
				s = { "<cmd>Tmux iex -S mix phx.server<cr>", "phx.server" },
				d = { "<cmd>Tmux mix dialyzer<cr>", "dialyzer" },
				l = { "<cmd>Tmux mix credo --strict<cr>", "credo" },
				q = { "<cmd>Tmux quality<cr>", "quality" },
				f = { "<cmd>Tmux mix format<cr>", "format" },
			},
		},

		r = {
			name = "terminal",
			i = { "<cmd>lua _iex()<cr>", "iex" },
			m = { "<cmd>lua _mix()<cr>", "mix" },
			p = { "<cmd>lua _phx()<cr>", "phx.server" },
			f = { "<cmd>ToggleTerm direction=float<cr>", "float" },
			h = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "horizontal" },
			v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "vertical" },
		},

		o = {
			name = "open tree",
			t = { "<cmd>NvimTreeToggle<cr>", "toggle" },
			f = { "<cmd>NvimTreeFindFile<cr>", "find file" },
			r = { "<cmd>NvimTreeRefresh<cr>", "refresh" },
		},

		t = {
			name = "test",
			["."] = { "<cmd>TestLast<cr>", "last" },
			n = { "<cmd>TestNearest<cr>", "nearest" },
			f = { "<cmd>TestFile<cr>", "file" },
			s = { "<cmd>TestSuite<cr>", "suite" },
			v = { "<cmd>TestVisit<cr>", "visit" },
		},

		w = {
			name = "window",
			j = { "<cmd>split<cr>", "split down" },
			l = { "<cmd>vsp<cr>", "split right" },
			w = { "<cmd>InteractiveWindow<cr>", "interactive" },
			p = { "<cmd>BufferLinePick<cr>", "pick" },
		},

		p = {
			name = "packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},

		g = {
			name = "git",
			g = { "<cmd>lua _lazygit_toggle()<CR>", "Lazygit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
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
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Diff",
			},
		},

		l = {
			name = "LSP",
			d = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
			D = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
			h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
			g = { "<cmd>Telescope lsp_document_diagnostics<cr>", "document diagnostics" },
			f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
			i = { "<cmd>LspInfo<cr>", "info" },
			I = { "<cmd>LspInstallInfo<cr>", "installer info" },
			j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next diagnostic" },
			k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "prev diagnostic" },
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "open quickfix" },
			s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "signature" },
			S = { "<cmd>Telescope lsp_document_symbols<cr>", "document dymbols" },
		},

		s = {
			name = "search",
			s = { "<cmd>lua require('telescope.builtin').resume()<cr>", "resume" },
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "files" },
			g = { "<cmd>lua require('telescope.builtin').git_files()<cr>", "git files" },
			a = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "all" },
			u = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "under cursor" },
			b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "buffers" },
			m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "marks" },
			h = { "<cmd>lua require('telescope.builtin').search_history()<cr>", "history" },
			c = { "<cmd>lua require('telescope.builtin').command_history()<cr>", "command history" },
			r = {
				name = "replace",
				t = { "<cmd>lua require('spectre').open()<cr>", "toggle" },
				w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "current word" },
			},
		},

		d = {
			name = "Debug",
			b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "breakpoint" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
			u = {
				name = "UI",
				o = { "<cmd>lua require'dapui'.open()<cr>", "open" },
				c = { "<cmd>lua require'dapui'.close()<cr>", "close" },
				t = { "<cmd>lua require'dapui'.toggle()<cr>", "toggle" },
			},
		},
	}

	plugin.setup(setup)
	plugin.register(mappings, opts)
end

return M
