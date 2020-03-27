scriptencoding utf-8
source ~/.vim/plugins

let mapleader="\<SPACE>"
set encoding=utf-8
set hidden
set title
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
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=30
set statusline+=%f
set lazyredraw
set ignorecase smartcase
set undodir=~/.vim/undodir
set undofile
set pyx=3

" reload vim
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

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

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax on
colorscheme onedark

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1
nnoremap <silent> <Leader>S :Rg <C-R><C-W><CR>
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" winresizer
" let g:winresizer_start_key = '<C-w>'

" vista
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width     = 100
let g:vista_close_on_jump     = 1
let g:vista_keep_fzf_colors   = 1

" key mapping
inoremap jk <Esc>
imap kj <Esc>
nnoremap j gj
nnoremap k gk
nmap <leader>i :w<CR>

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
nmap <leader>h :History<CR>
nmap <leader>a :Vista!!<CR>
nmap <leader>e :BLines<CR>
nmap <leader>e :Lines<CR>
nmap <leader>s :Rg<CR>
nmap <leader>m :Marks<CR>

" move lines
nnoremap <C-u> :m .+1<CR>==
nnoremap <C-i> :m .-2<CR>==
inoremap <C-u> <ESC>:m .+1<CR>==gi
inoremap <C-i> <ESC>:m .-2<CR>==gi
vnoremap <C-u> :m '>+1<CR>gv=gv
vnoremap <C-i> :m '<-2<CR>gv=gv

nnoremap <leader><Tab> :b#<CR>

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <C-y> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

let g:coc_snippet_next = '<tab>'

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gf <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> gl <Plug>(coc-codelens-action)
nmap <silent> gx <Plug>(coc-fix-current)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> gs :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc-snippets
inoremap <silent><expr> <c-space> coc#refresh()
let g:coc_snippet_next = '<tab>'

" tslime
let g:tslime_always_current_session = 1

" vim-test
let test#strategy = "tslime"
let g:test#preserve_screen = 1
nnoremap <leader>. :TestLast<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tv :TestVisit<CR>

" tmux commands
nmap <leader>td :Tmux mix dialyzer<CR>
nmap <leader>tq :Tmux mix quality<CR>

" terminal
tnoremap <Esc> <C-\><C-n>

" nerdtree
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 80
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
map <leader>o :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-airline
let g:airline_theme='onedark'

" tagalong
let g:tagalong_additional_filetypes = ['eex', 'leex', 'eelixir']

" zoomwintab.vim
nnoremap <leader>z :ZoomWinTabToggle<CR>

" vim-fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" far.vim
let g:far#source = "rgnvim"
let g:far#ignore_files = ['~/.vim/farignore']
let g:far#window_width = 200
let g:far#preview_window_width = 200
let g:far#default_file_mask = "**/*.*"

" vim-matchup
let g:matchup_matchparen_deferred = 1
