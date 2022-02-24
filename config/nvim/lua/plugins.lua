local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("lewis6991/impatient.nvim")

	use("nvim-lua/popup.nvim")

	use("nvim-lua/plenary.nvim")

	use({
		"navarasu/onedark.nvim",
		config = function()
			local theme = require("onedark")
			theme.load()
			theme.setup({
				style = "warm",
			})
		end,
	})

	use("tpope/vim-sensible")

	use("tpope/vim-sleuth")

	use({
		"nathom/filetype.nvim",
		config = function()
			require("plugins.filetype").config()
		end,
	})

	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha").config()
		end,
	})

	use({
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("plugins.comment").config()
		end,
	})

	--use("ahmedkhalf/project.nvim")

	use({
		"folke/which-key.nvim",
		config = function()
			require("plugins.which-key").config()
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufRead",
		cmd = {
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSDisableAll",
			"TSEnableAll",
		},
		config = function()
			require("plugins.treesitter").config()
		end,
		requires = {
			{
				"p00f/nvim-ts-rainbow",
				after = "nvim-treesitter",
			},
			{
				"windwp/nvim-ts-autotag",
				after = "nvim-treesitter",
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				after = "nvim-treesitter",
			},
		},
	})

	-- use("nvim-treesitter/nvim-treesitter-textobjects")

	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope").config()
		end,
	})

	use("windwp/nvim-spectre")

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	use("kyazdani42/nvim-web-devicons")

	use({
		"kyazdani42/nvim-tree.lua",
		cmd = {
			"NvimTreeToggle",
			"NvimTreeFindFile",
		},
		config = function()
			require("plugins.nvim-tree").config()
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.bufferline").config()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"max397574/better-escape.nvim",
		event = { "InsertEnter" },
		config = function()
			require("better_escape").setup({
				mapping = { "ii", "jj", "jk", "kj" },
				timeout = vim.o.timeoutlen,
				keys = "<ESC>",
			})
		end,
	})

	use({
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup()
		end,
	})

	use({
		"moll/vim-bbye",
		after = "bufferline.nvim",
	})

	use({
		"nvim-lualine/lualine.nvim",
		after = "bufferline.nvim",
		config = function()
			require("plugins.lualine").config()
		end,
	})

	use({
		"akinsho/nvim-toggleterm.lua",
		config = function()
			require("plugins.term").config()
		end,
	})

	use({
		"antoinemadec/FixCursorHold.nvim",
		event = "BufRead",
		config = function()
			vim.g.cursorhold_updatetime = 100
		end,
	})

	use("tbastos/vim-lua")

	use("elixir-editors/vim-elixir")

	use({
		"vim-test/vim-test",
		config = function()
			require("plugins.test").config()
		end,
	})

	use("danilamihailov/beacon.nvim")

	use("romgrk/winteract.vim")

	use({
		"tpope/vim-projectionist",
		config = function()
			require("plugins.projectionist").config()
		end,
	})

	use("romainl/vim-cool")

	-- use({
	-- 	"Pocco81/AutoSave.nvim",
	-- 	config = function()
	-- 		require("autosave").setup()
	-- 	end,
	-- })

	use({
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	})

	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp").config()
		end,
	})

	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use("mfussenegger/nvim-dap")
	use({
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
