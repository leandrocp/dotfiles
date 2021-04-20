" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" https://www.reddit.com/r/vim/wiki/vimrctips
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" function! PackagerInit() abort
"   packad vim-packager
"   call packager#init()
"   call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
"   call packager#add('tpope/vim-sensible')
"   call packager#add('tpope/vim-sleuth')

"   " call packager#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})

"   call packager#add('antoinemadec/FixCursorHold.nvim')
"   call packager#add('lambdalisue/fern.vim')

"   call packager#add('christoomey/vim-tmux-navigator')
"   call packager#add('embark-theme/vim', { 'name': 'embark' })
"   " call packager#add('sheerun/vim-polyglot')
"   call packager#add('farmergreg/vim-lastplace')
"   call packager#add('tpope/vim-repeat')
"   call packager#add('tpope/vim-commentary')
"   call packager#add('vim-test/vim-test')
"   call packager#add('jgdavey/tslime.vim')
"   call packager#add('tpope/vim-projectionist')
"   call packager#add('srstevenson/vim-picker')
"   call packager#add('mhinz/vim-grepper')
"   call packager#add('mbbill/undotree')
"   call packager#add('danilamihailov/beacon.nvim')
"   call packager#add('sbdchd/neoformat')
"   call packager#add('elixir-editors/vim-elixir')
"   call packager#add('cohama/lexima.vim')
"   call packager#add('kassio/neoterm')
"   call packager#add('wsdjeg/vim-fetch')
"   " call packager#add('neovim/nvim-lspconfig')
"   call packager#add('rizzatti/dash.vim')

"   " call packager#add('ap/vim-buftabline')
"   " call packager#add('zefei/vim-wintabs')
"   " call packager#add('vim-airline/vim-airline')
"   " call packager#add('bagrat/vim-buffet')
"   " call packager#add('pacha/vem-tabline')
"   " call packager#add('gcmt/taboo.vim')
"   call packager#add('mkitt/tabline.vim')
"   " call packager#add('romainl/vim-qf')

"   " call packager#add('liuchengxu/vim-clap')
"   call packager#add('earthly/earthly.vim')

"   call packager#add('nvim-lua/popup.nvim')
"   call packager#add('nvim-lua/plenary.nvim')
"   call packager#add('nvim-telescope/telescope.nvim')

"   call packager#add('romgrk/winteract.vim')

"   call packager#add('mhinz/vim-sayonara')
" endfunction

" " -- packager
" command! PackagerInstall call PackagerInit() | call packager#install()
" command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
" command! PackagerClean call PackagerInit() | call packager#clean()
" command! PackagerStatus call PackagerInit() | call packager#status()

lua require('plugins')
autocmd BufWritePost plugins.lua PackerCompile

" -- global
nnoremap <SPACE> <Nop>
" let mapleader=" "
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set termguicolors
set background=dark
colorscheme embark
" set cursorline
set title
set splitbelow
set splitright
set statusline+=%f
set visualbell t_vb=
set inccommand=nosplit
let loaded_netrw = 0
set scrolloff=10
set autowrite
set nojoinspaces
set clipboard+=unnamedplus
set undofile
set undolevels=1000
set undodir=~/.vim/undodir
set history=10000
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set pyx=3
set wildignore+=*.pyc,*.pyo,*/__pycache__/*
set wildignore+=*.swp,~*
set wildignore+=*.zip,*.tar
set hidden
set mouse=a
set number
set ignorecase
set smartcase
set incsearch
au BufEnter * set fo-=c fo-=r fo-=o  " stop annoying auto commenting on new lines

" reload vimrc
if has ('autocmd')
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

" reload changed files on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" autosave
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
au BufLeave,FocusLost * silent! wa

" enable spell only if file type is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif

" open help in vertical split
autocmd FileType help wincmd L

" windows
noremap <leader>wl :vsp<CR>
noremap <leader>wj :split<CR>
noremap <leader>wt :tabnew<CR>
noremap <leader>wq :q<CR>

" -- winteract.vim
nmap <leader>ww :InteractiveWindow<CR>

" -- tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>h gT
noremap <leader>l gt
noremap <Tab> gt

" -- buffer
noremap <leader>bf :Neoformat<CR>

" -- FixCursorHold
let g:cursorhold_updatetime = 100

" -- fern
let g:fern#disable_default_mappings   = 1
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 1

function! s:init_fern() abort
  nmap <buffer><expr>
      \ <Plug>(fern-my-open-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open:select)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> o <Plug>(fern-my-open-expand-collapse)

  nmap <buffer> n <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> yy <Plug>(fern-action-yank)
  nmap <buffer> yp <Plug>(fern-action-yank-path)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> g <Plug>(fern-action-mark:toggle)
  nmap <buffer> <nowait> t <Plug>(fern-action-hidden:toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

noremap <silent> <Leader>o :Fern . -drawer -reveal=% -width=40<CR><C-w>=

" -- vim-projectionist
let g:projectionist_heuristics = {
  \ "mix.exs": {
    \ 'apps/*/mix.exs': { 'type': 'app' },
    \ 'lib/*.ex': {
    \   'type': 'lib',
    \   'alternate': 'test/{}_test.exs',
    \   'template': ['defmodule {camelcase|capitalize|dot} do', 'end'],
    \ },
    \ 'test/*_test.exs': {
    \   'type': 'test',
    \   'alternate': 'lib/{}.ex',
    \   'template': [
    \       'defmodule {camelcase|capitalize|dot}Test do',
    \       '  use ExUnit.Case',
    \       '',
    \       'end'
    \   ],
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

" -- vim-picker
" let g:picker_height = 20
" nmap <leader>f <Plug>(PickerEdit)
" nmap <leader>ps <Plug>(PickerSplit)
" nmap <leader>pt <Plug>(PickerTabedit)
" nmap <leader>pv <Plug>(PickerVsplit)
" nmap <leader>pb <Plug>(PickerBuffer)
" nmap <leader>p] <Plug>(PickerTag)
" nmap <leader>pw <Plug>(PickerStag)
" nmap <leader>po <Plug>(PickerBufferTag)
" nmap <leader>ph <Plug>(PickerHelp)

" -- telescope.nvim
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
lua << EOF
local actions = require('telescope.actions')
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter
  }
}
EOF

" -- vim-grepper
let g:grepper = {}
runtime plugin/grepper.vim
    let g:grepper = { 'open': 0 }
    autocmd User Grepper copen
let g:grepper.highlight = 1
let g:grepper.dir = 'repo,cwd'
let g:grepper.repo = ['.git']
let g:grepper.tools = ["rg"]
let g:grepper.rg = {
  \ 'grepprg': 'rg --with-filename --no-heading --smart-case --vimgrep',
\ }
nnoremap <leader>* :Grepper -tool rg -open -switch -cword -noprompt<cr>
nnoremap <Leader>// :GrepperRg<Space>
nnoremap <Leader>/w :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -tweb '$*'<cr>
nnoremap <Leader>/t :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -ttml '$*'<cr>
nnoremap <Leader>/s :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -tsrc '$*'<cr>

" -- clap

" -- tslime
let g:tslime_always_current_session = 1

" -- vim-test
let test#strategy = "tslime"
let g:test#preserve_screen = 1
nnoremap <leader>. :TestLast<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tv :TestVisit<CR>

" -- tmux commands
nmap <leader>td :Tmux mix dialyzer<CR>
nmap <leader>tq :Tmux mix quality<CR>

" -- undotree
let g:undotree_WindowLayout       = 4
let g:undotree_SetFocusWhenToggle = 1
nnoremap <Leader>u :UndotreeToggle<CR>

" -- mappings
noremap ; :
inoremap kj <Esc>
imap kj <Esc>
noremap <leader>s :w<CR>
noremap <leader>q :bd<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader><Tab> :b#<CR>
noremap <silent><esc> <esc>:noh<CR><esc>

" -- dash.vim
nmap <silent> <leader>d <Plug>DashSearch
