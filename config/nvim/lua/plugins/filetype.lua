local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "filetype")
	if not status_ok then
		return
	end

	plugin.setup({
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
end

return M
