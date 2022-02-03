local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	plugin.setup({
		ensure_installed = {
			"lua",
			"html",
			"css",
			"json",
			"jsonc",
			"bash",
			"erlang",
			"elixir",
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		refactor = {
			highlight_definitions = { enable = true },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	})
end

return M
