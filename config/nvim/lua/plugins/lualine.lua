local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "lualine")
	if not status_ok then
		return
	end

	local hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn" },
		symbols = { error = "e", warn = "w" },
		colored = false,
		update_in_insert = false,
		always_visible = true,
	}

	local diff = {
		"diff",
		colored = true,
		symbols = { added = "+", modified = "~", removed = "-" },
		cond = hide_in_width,
	}

	local mode = {
		"mode",
		fmt = function(str)
			return "-- " .. str .. " --"
		end,
	}

	local filetype = {
		"filetype",
		icons_enabled = true,
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
			theme = "dracula",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { mode },
			lualine_a = { branch },
			lualine_c = { diagnostics },
			lualine_x = { filetype, "encoding" },
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
		extensions = {},
	})
end

return M
