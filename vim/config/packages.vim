if &compatible
  set nocompatible
endif

" Load packager only when you need it
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('romainl/vim-qf')
  call packager#add('bluz71/vim-nightfly-guicolors')
  call packager#add('sonph/onehalf', {'rtp': 'vim/'})
  call packager#add('tpope/vim-sensible')
  call packager#add('rstacruz/vim-opinion')
  call packager#add('tpope/vim-sleuth')
  call packager#add('wellle/targets.vim')
  call packager#add('kana/vim-textobj-user')
  call packager#add('andyl/vim-textobj-elixir')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('troydm/zoomwintab.vim')
  call packager#add('farmergreg/vim-lastplace')
  call packager#add('tpope/vim-projectionist')
  call packager#add('sheerun/vim-polyglot')
  call packager#add('elixir-editors/vim-elixir')
  call packager#add('tpope/vim-repeat')
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-endwise')
  call packager#add('lambdalisue/fern.vim')
  call packager#add('srstevenson/vim-picker')
  call packager#add('rhysd/clever-f.vim')
  call packager#add('igemnace/vim-makery')
  call packager#add('tpope/vim-dispatch')
  call packager#add('vim-test/vim-test')
  call packager#add('kassio/neoterm')
  call packager#add('mhinz/vim-grepper')
  call packager#add('mbbill/undotree')
  call packager#add('tpope/vim-fugitive')
  call packager#add('jgdavey/tslime.vim')
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()
