local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"erlangls",
	"elixirls",
	"tailwindcss",
	"terraformls",
	"tslint",
	"dockerls",
	"yamlls",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			print("Installing LS " .. name)
			server:install()
		end
	end
end

lsp_installer.on_server_ready(function(server)
	local opts = {}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("plugins.lsp.settings.lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "elixirls" then
		local elixirls_opts = require("plugins.lsp.settings.elixir")
		opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
	end

	server:setup(opts)
end)
