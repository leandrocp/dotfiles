local present, lualine = pcall(require, "lualine")

if not present then
  return
end

local options = {
  options = {
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
    icons_enabled = false
  }
}

lualine.setup(options)
