local present, lualine = pcall(require, "lualine")

if not present then
  return
end

local options = {
  options = {
    theme = 'onedark',
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
  }
}

lualine.setup(options)
