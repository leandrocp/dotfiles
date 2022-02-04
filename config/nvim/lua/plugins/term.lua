local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "toggleterm")
	if not status_ok then
		return
	end

	plugin.setup({
		size = 20,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
		shade_terminals = false,
	})

	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	local Terminal = require("toggleterm.terminal").Terminal

	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
	})

	function _lazygit_toggle()
		lazygit:toggle()
	end

	local iex = Terminal:new({ cmd = "iex", hidden = true })
	function _iex_toggle()
		iex:toggle()
	end

	local mix = Terminal:new({ cmd = "iex -S mix", hidden = true })
	function _mix_toggle()
		mix:toggle()
	end

	local phx = Terminal:new({ cmd = "iex -S mix phx.server", hidden = true })
	function _mix_toggle()
		phx:toggle()
	end
end

return M
