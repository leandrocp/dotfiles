local M = {}

function M.config()
	local status_ok, plugin = pcall(require, "bufferline")
	if not status_ok then
		return
	end

	plugin.setup({
		options = {
			buffer_close_icon = "",
			max_name_length = 30,
			max_prefix_length = 30,
			tab_size = 21,
			diagnostics = "nvim_lsp",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true,
			separator_style = "thin",
			enforce_regular_tabs = true,
			always_show_bufferline = true,
		},
	})
end

return M
