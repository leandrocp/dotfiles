local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "nvim-tree")
	if not status_ok then
		return
	end

	local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
	if not config_status_ok then
		return
	end

	local tree_cb = nvim_tree_config.nvim_tree_callback

	plugin.setup({
		ignore_ft_on_setup = {
			"startify",
			"dashboard",
			"alpha",
		},
		auto_close = true,
		open_on_tab = false,
		hijack_cursor = true,
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		view = {
			width = 40,
			height = 30,
			auto_resize = true,
			mappings = {
				custom_only = false,
				list = {
					{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "v", cb = tree_cb("vsplit") },
				},
			},
		},
		git_hl = 1,
		root_folder_modifier = ":t",
	})
end

return M
