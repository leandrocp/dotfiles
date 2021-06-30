local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'tpope/vim-sensible'
  -- use {'embark-theme/vim', as = 'embark'}
  use 'shaunsingh/nord.nvim'
  use 'tanvirtin/monokai.nvim'
  use 'chriskempson/base16-vim'
  use "rafamadriz/neon"
  use 'navarasu/onedark.nvim'
  use 'christoomey/vim-tmux-navigator'
  -- use 'rizzatti/dash.vim'
  use 'vim-test/vim-test'
  use 'jgdavey/tslime.vim'
  use 'lambdalisue/fern.vim'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-repeat'
  use 'ethanholz/nvim-lastplace'
  -- use 'wsdjeg/vim-fetch'
  use 'danilamihailov/beacon.nvim'
  use 'romgrk/winteract.vim'
  -- use 'mhinz/vim-sayonara'
  use 'tpope/vim-commentary'
  use 'kshenoy/vim-signature'
  use 'tpope/vim-projectionist'
  -- use 'tami5/sql.nvim'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    config = function()
      require"telescope".load_extension("fzy_native")
    end
  }
  use 'elixir-editors/vim-elixir'
  use 'neovim/nvim-lspconfig'
  -- use 'nvim-lua/completion-nvim'
  -- use 'albertoCaroM/completion-tmux'
  -- use 'steelsojka/completion-buffers'
  -- use 'kristijanhusak/vim-dadbod-completion'
  -- use 'sjl/gundo.vim'
  -- use 'luochen1990/rainbow'
  -- use 'sheerun/vim-polyglot'
  -- use 'tpope/vim-dadbod'
  -- use 'kristijanhusak/vim-dadbod-ui'
  use 'sbdchd/neoformat'
  -- use 'tpope/vim-fugitive'
  -- use 'christoomey/vim-conflicted'
  -- use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-bufferline.lua'
  -- use 'hoob3rt/lualine.nvim'
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'p00f/nvim-ts-rainbow'

  use "hrsh7th/nvim-compe"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"
end)
