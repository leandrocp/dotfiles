local M = {}

function M.config()
	vim.cmd([[
    let test#strategy = "neovim"
    let g:test#preserve_screen = 1
    ]])
end

return M
