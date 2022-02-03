local M = {}

function M.config()
	vim.cmd([[
    let test#strategy = "tslime"
    let g:test#preserve_screen = 1
    ]])
end

return M
