local options = {
	background = "dark",
	backupdir = "~/.cache/nvim/backup",
	clipboard = "unnamedplus",
	cmdheight = 2,
	completeopt = "menuone,noselect",
	conceallevel = 0,
	cursorline = false,
	dir = "~/.cache/nvim/swap",
	fileencoding = "utf-8",
	foldenable = false,
	incsearch = true,
	ignorecase = true,
	hlsearch = true,
	hidden = true,
	history = 100,
	laststatus = 2,
	lazyredraw = true,
	listchars = "tab:│ ,nbsp:␣,trail:·,extends:>,precedes:<",
	mouse = "a",
	number = true,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 30,
	shiftwidth = 4,
	sidescrolloff = 8,
	signcolumn = "yes",
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	softtabstop = 4,
	splitbelow = true,
	splitright = true,
	synmaxcol = 240,
	swapfile = true,
	tabstop = 4,
	termguicolors = true,
	undodir = "~/.cache/nvim/undodir",
	undofile = true,
	undolevels = 1000,
	wildignore = [[
		.git,.hg,.svn
		*.aux,*.out,*.toc
		*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
		*.pyc,*.pyo,*/__pycache__/*
		*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
		*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
		*.mp3,*.oga,*.ogg,*.wav,*.flac
		*.eot,*.otf,*.ttf,*.woff
		*.doc,*.pdf,*.cbr,*.cbz
		*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
		*.swp,.lock,.DS_Store,._*
	]],
	wildmenu = true,
	wrap = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("c")

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
