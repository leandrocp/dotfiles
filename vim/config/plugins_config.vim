" fzf
let $FZF_DEFAULT_OPTS="--reverse "
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
set grepprg=rg\ --vimgrep
nnoremap <silent> <Leader>S :Rg <C-R><C-W><CR>

" tslime
let g:tslime_always_current_session = 1

" vim-test
let test#strategy = "tslime"
let g:test#preserve_screen = 1
nnoremap <leader>. :TestLast<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tv :TestVisit<CR>

" tmux commands
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
"" let g:indentLine_setColors = 0
"" let g:indentLine_setConceal = 0
"" let g:vim_json_conceal = 0

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
"" xmap ga <Plug>(EasyAlign)
"" nmap ga <Plug>(EasyAlign)

let g:omni_sql_no_default_maps = 1      " disable sql omni completion

" splitjoin.vim
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>
