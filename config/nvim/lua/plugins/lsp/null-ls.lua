local status_ok, plugin = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = plugin.builtins.formatting
local diagnostics = plugin.builtins.diagnostics
local code_actions = plugin.builtins.code_actions

plugin.setup({
	sources = {
		formatting.stylua,
		formatting.mix,
		formatting.surface,
		formatting.terraform_fmt,
		diagnostics.credo,
		code_actions.gitsigns,
	},
})
