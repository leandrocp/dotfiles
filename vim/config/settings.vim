scriptencoding utf-8

" file
set encoding=utf-8
set autoread
set autowrite

" editor
set nojoinspaces
set emoji
set backspace=indent,eol,start          " sensible backspacing
set list listchars=trail:»,tab:»-       " use tab to navigate in list mode

" ui
set termguicolors
set background=dark
colorschem onehalfdark
syntax on
set cursorline
set title
set splitbelow
set splitright
set statusline+=%f
set visualbell t_vb=
set inccommand=nosplit                  " visual feedback while substituting
let loaded_netrw = 0                    " diable netrw
set scrolloff=10                        " Minimum number of lines to always show above/below the caret.
set updatetime=100

" os
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

" stop annoying auto commenting on new lines
au BufEnter * set fo-=c fo-=r fo-=o

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

" open files preview on enter and provided arg is a folder
autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif
autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | Files | endif

" auto html tags closing, enable for markdown files as well
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.md'
