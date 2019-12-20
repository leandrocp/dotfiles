scriptencoding utf-8
source ~/.vimplugins

let mapleader="\<SPACE>"
set encoding=utf-8
set title
" set clipboard+=unnamedplus
set clipboard=unnamed
set signcolumn=yes
set shortmess+=c
set termguicolors
set autoread
set splitbelow
set splitright
set nojoinspaces
set nocursorline
set visualbell t_vb=

" reload changed files on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

if has('gui_running')
  " Settings for when running in a GUI
  set transparency=0
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14
  set guioptions+=gme " gray menu items, menu bar, gui tabs
  set antialias
  set guioptions=
  autocmd! GUIEnter * set vb t_vb=
else
  " terminal
  function! Term()
    exec winheight(0)/4."split" | terminal
  endfunction
  nnoremap <expr> <leader>m ":call Term()\<CR>"
  autocmd TermOpen term://* startinsert
endif

" theme
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
colorscheme onedark

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~40%' }

" vim-test
let test#vim#term_position = "belowright"
let test#strategy = "neovim"

" winresizer
let g:winresizer_start_key = '<leader>w'

" vista
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#icons = {
\   "function": "",
\   "variable": "",
\  }

" key mapping
inoremap jk <esc>
nnoremap j gj
nnoremap k gk

" kb
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <leader>F :GFiles<CR>
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>y :History<CR>
nmap <leader>a :Vista!!<CR>
nmap <leader>i :BLines<CR>
nmap <leader>I :Lines<CR>
nmap <leader>s :Rg<CR>

nnoremap <leader><Tab> :b#<CR>

" ale
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '!'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
" let g:ale_elixir_elixir_ls_release = '/Users/leandro/code/github/elixir-lsp/elixir-ls/release'
let g:ale_elixir_elixir_ls_release = '/Users/leandro/code/github/JakeBecker/elixir-ls/release'
let g:ale_elixir_elixir_ls_config = { 'elixirLS': { 'dialyzerEnabled': v:false } }
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'elixir': ['elixir-ls'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\}
nnoremap gd :ALEGoToDefinition<cr>
nnoremap gr :ALEFindReferences<CR>
nnoremap bf :ALEFix<cr>
nnoremap K :ALEHover<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" vim-test
let test#strategy = "iterm"
let g:test#preserve_screen = 1
nnoremap <leader>. :TestLast<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tv :TestVisit<CR>

" terminal
tnoremap <Esc> <C-\><C-n>
