scriptencoding utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" == [PLUGINS] ==
call plug#begin('~/.vim/plugged')

" -- base
Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-sleuth'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'andyl/vim-textobj-elixir'

" -- interface
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'haishanh/night-owl.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'chriskempson/base16-vim'
Plug 'yggdroot/indentline'
Plug 'simeji/winresizer'
Plug 'itchyny/lightline.vim'
Plug 'troydm/zoomwintab.vim'
Plug 'scrooloose/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'farmergreg/vim-lastplace'

" -- project & navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/fuzzy-projectionist.vim'
Plug 'kshenoy/vim-signature'
Plug 'janko/vim-test'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-eunuch'

" -- editing & integration
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'honza/vim-snippets'
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'jgdavey/tslime.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'junegunn/vim-easy-align'

call plug#end()

" == [OPTIONS] ==
set encoding=utf-8
set history=1000
set clipboard+=unnamedplus
set autoread
set splitbelow
set splitright
set nojoinspaces
set visualbell t_vb=
set statusline+=%f
set ignorecase smartcase
set undodir=~/.vim/undodir
set undofile
set pyx=3
set emoji
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set backspace=indent,eol,start                          " sensible backspacing
set foldlevel=0                                         " open all folds by default
set inccommand=nosplit                                  " visual feedback while substituting
let loaded_netrw = 0                                    " diable netew
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
" -- visual
set title
set termguicolors
set cursorline
syntax on
" colorscheme onehalfdark
" colorscheme night-owl
colorscheme nightfly

" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" -- performance
set nocursorcolumn
set scrolljump=10
set lazyredraw
set synmaxcol=180
set re=1
" -- coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" == [ACTIONS] ==
" -- reload vimrc
if has ('autocmd')
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

" -- reload changed files on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" == [KEY MAPPINGS] ==
let mapleader="\<SPACE>"
nnoremap ; :
inoremap jk <Esc>
imap kj <Esc>
nnoremap j gj
nnoremap k gk
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nmap <leader>w :w<CR>
nmap <leader>q :bd<CR>
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
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nmap <leader>F :GFiles<CR>
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>a :Vista!!<CR>
nmap <leader>l :Lines<CR>
nmap <leader>s :Rg<CR>
nmap <leader>m :Marks<CR>
nmap <leader>t :Vista finder<CR>
" nnoremap <C-u> :m .+1<CR>==
" nnoremap <C-i> :m .-2<CR>==
" inoremap <C-u> <ESC>:m .+1<CR>==gi
" inoremap <C-i> <ESC>:m .-2<CR>==gi
" vnoremap <C-u> :m '>+1<CR>gv=gv
" vnoremap <C-i> :m '<-2<CR>gv=gv
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nnoremap <leader><Tab> :b#<CR>
" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" == [FILETYPE] ==
" enable spell only if file type is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif
" open help in vertical split
autocmd FileType help wincmd L
" open files preview on enter and provided arg is a folder
autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif
autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | Files | endif
" auto html tags closing, enable for markdown files as well
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.md'

" == [PLUGINS CONFIG] ==
" -- fzf
let $FZF_DEFAULT_OPTS="--reverse "
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
let g:fzf_buffers_jump = 1
set grepprg=rg\ --vimgrep
nnoremap <silent> <Leader>S :Rg <C-R><C-W><CR>
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" files window with preview
command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" -- vista
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width     = 100
let g:vista_close_on_jump     = 1
let g:vista_keep_fzf_colors   = 1

" -- coc
let g:coc_global_extensions = [
            \'coc-prettier',
            \'coc-snippets',
            \'coc-ultisnips',
            \'coc-syntax',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-elixir'
            \]


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gf <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> gl <Plug>(coc-codelens-action)
nmap <silent> gx <Plug>(coc-fix-current)
nnoremap <silent> gs :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" -- coc-snippets
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'

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

" -- terminal
tnoremap <Esc> <C-\><C-n>

" -- nerdtree
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 80
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
map <leader>o :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -- zoomwintab.vim
nnoremap <leader>z :ZoomWinTabToggle<CR>

" -- vim-fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" -- vim-dispatch
let g:dispatch_compilers = {
    \ "mix test": "exunit",
    \ "mix compile": "mix"
    \ }

" -- indentLine
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0
let g:vim_json_conceal = 0

" -- lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" -- easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
