local status_ok, plugin = pcall(require, "project_nvim")
if not status_ok then
	return
end

plugin.setup({
	on_config_done = nil,
	detection_methods = { "pattern" },
	silent_chdir = false,
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension("projects")
