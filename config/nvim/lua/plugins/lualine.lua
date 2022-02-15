local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "lualine")
	if not status_ok then
		return
	end

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic", "nvim_lsp" },
		sections = { "error", "warn", "hint" },
		symbols = { error = "e", warn = "w" },
		colored = true,
		update_in_insert = false,
		always_visible = false,
	}

	local filetype = {
		"filetype",
		icons_enabled = true,
	}

	local filename = {
		"filename",
		file_status = true,
		path = 1,
	}

	local branch = {
		"branch",
		icons_enabled = true,
		icon = "",
	}

	local location = {
		"location",
		padding = 0,
	}

	local progress = function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end

	plugin.setup({
		options = {
			icons_enabled = true,
			theme = "onedark",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { branch },
			lualine_c = { diagnostics },
			lualine_x = { filetype, filename, "encoding" },
			lualine_y = { location },
			lualine_z = { progress },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "nvim-tree", "toggleterm" },
	})
end

return M
