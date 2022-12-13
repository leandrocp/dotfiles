local present, lualine = pcall(require, "lualine")

if not present then
  return
end

local options = {
  options = {
    globalstatus = true
  }
}

lualine.setup(options)
