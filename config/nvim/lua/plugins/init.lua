local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'olimorris/onedarkpro.nvim'

  use 'nvim-lua/plenary.nvim'

  use 'tpope/vim-sleuth'

  use {
    'stevearc/dressing.nvim',
    config = function()
      require("dressing").setup()
    end
  }

  use 'nvim-tree/nvim-web-devicons'

  use {
    'akinsho/bufferline.nvim',
    config = function()
      require 'plugins.configs.bufferline'
    end
  }

  use 'ojroques/nvim-bufdel'

  use 'folke/which-key.nvim'

  use {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup()
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'plugins.configs.telescope'
    end
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        view = {
          adaptive_size = true,
          width = 45,
        },
      })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugins.configs.lualine'
    end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require 'plugins.configs.lsp'
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end
  }

  use 'tpope/vim-repeat'

  use {
    "vim-test/vim-test",
    config = function()
      vim.cmd([[
        let g:test#preserve_screen = 1
        let test#strategy = "kitty"
      ]])
    end,
  }

  use 'kdheepak/lazygit.nvim'

  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "kj" },
      })
    end,
  }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  }

  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    'ethanholz/nvim-lastplace',
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  }

  use 'romainl/vim-cool'

  use {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,
        show_cursorline = true,
      })
    end,
  }

  use {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  }

  use {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require "plugins.configs.smartsplits"
    end,
  }

  use {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  }

  use {
    "knubie/vim-kitty-navigator",
    run = "cp *.py ~/.config/kitty/",
  }

  use {
    "tpope/vim-projectionist",
    config = function()
      vim.cmd([[
let g:projectionist_heuristics = {
  \ "mix.exs": {
    \ 'apps/*/mix.exs': { 'type': 'app' },
    \ 'lib/*.ex': {
    \   'type': 'source',
    \   'alternate': 'test/{}_test.exs',
    \   'template': [
    \     'defmodule {camelcase|capitalize|dot} do',
    \     'end'
    \   ],
    \ },
    \ 'test/*_test.exs': {
    \   'type': 'test',
    \   'alternate': 'lib/{}.ex',
    \   'template': [
    \     'defmodule {camelcase|capitalize|dot}Test do',
    \     '  use ExUnit.Case, async: true',
    \     '',
    \     '  alias {camelcase|capitalize|dot}',
    \     '',
    \     'end'
    \   ],
    \ },
    \ 'lib/**/controllers/*_controller.ex': {
    \   'type': 'controller',
    \   'alternate': 'test/{dirname}/controllers/{basename}_controller_test.exs',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Controller do',
    \     '  use {dirname|camelcase|capitalize}, :controller',
    \     'end'
    \   ],
    \ },
    \ 'test/**/controllers/*_controller_test.exs': {
    \   'alternate': 'lib/{dirname}/controllers/{basename}_controller.ex',
    \   'type': 'test',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ControllerTest do',
    \     '  use {dirname|camelcase|capitalize}.ConnCase, async: true',
    \     'end'
    \   ]
    \ },
    \ 'lib/**/live/*_live.ex': {
    \   'type': 'live',
    \   'alternate': 'test/{dirname}/live/{basename}_live_test.exs',
    \   'related': [
    \     '{dirname|dirname}/views/{basename}_view.ex'
    \   ],
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Live do',
    \     '  use {dirname|camelcase|capitalize}, :live_view',
    \     '',
    \     '  def mount(_params, _session, socket) do',
    \     '    if connected?(socket), do: :ok',
    \     '',
    \     '    {:ok, socket |> assign(:page_title, "Foo")}',
    \     '  end',
    \     '',
    \     '  def render(assigns) do',
    \     '    {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View.render("foo.html", assigns)',
    \     '  end',
    \     'end'
    \   ]
    \ },
    \ '*eex': {
    \   'type': 'template',
    \   'related': [
    \     '{dirname|dirname|dirname}/controllers/{dirname|basename}_controller.ex',
    \     '{dirname|dirname|dirname}/live/{dirname|basename}_live.ex',
    \     '{dirname|dirname|dirname}/views/{dirname|basename}_view.ex'
    \   ]
    \ },
    \ 'lib/**/views/*_view.ex': {
    \   'type': 'view',
    \   'alternate': 'test/{dirname}/views/{basename}_view_test.exs',
    \   'related': [
    \     '{dirname|dirname}/live/{basename}_live.ex',
    \     '{dirname|dirname}/controllers/{basename}_controller.ex'
    \   ],
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View do',
    \     '  use {dirname|camelcase|capitalize}, :view',
    \     'end'
    \   ]
    \ },
    \ 'test/**/views/*_view_test.exs': {
    \   'alternate': 'lib/{dirname}/views/{basename}_view.ex',
    \   'type': 'test',
    \   'template': [
    \     'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ViewTest do',
    \     '  use ExUnit.Case, async: true',
    \     '',
    \     '  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View',
    \     'end'
    \   ]
    \ },
    \ 'mix.exs': { 'type': 'mix' },
    \ 'config/*.exs': { 'type': 'config' },
    \ '*.ex': {
    \   'makery': {
    \     'lint': { 'compiler': 'credo' },
    \     'test': { 'compiler': 'exunit' },
    \     'build': { 'compiler': 'mix' }
    \   }
    \ },
    \ '*.exs': {
    \   'makery': {
    \     'lint': { 'compiler': 'credo' },
    \     'test': { 'compiler': 'exunit' },
    \     'build': { 'compiler': 'mix' }
    \   }
    \ }
   \ }
  \ }
  ]]   )
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
