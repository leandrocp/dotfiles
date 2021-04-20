" fzf
" let $FZF_DEFAULT_OPTS="--reverse "
" let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
" let g:fzf_history_dir = '~/.local/share/fzf-history'
" let g:fzf_buffers_jump = 1
" set grepprg=rg\ --vimgrep
" nnoremap <silent> <Leader>S :Rg <C-R><C-W><CR>

" tslime
let g:tslime_always_current_session = 1

" vim-test
let test#strategy = "tslime"
let g:test#preserve_screen = 1
" let test#strategy = "neoterm"
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
" let g:NERDTreeWinPos = "right"
" let g:NERDTreeWinSize = 80
" let g:NERDTreeQuitOnOpen = 1
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeAutoDeleteBuffer = 1
" map <leader>o :NERDTreeFind<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

let g:omni_sql_no_default_maps = 1      " disable sql omni completion

" splitjoin.vim
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" vim-gh-line
let g:gh_line_map_default       = 0
let g:gh_line_blame_map_default = 0
let g:gh_use_canonical          = 1

" fern
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_auto_quit = 0
noremap <silent> <Leader>o :Fern . -toggle -reveal=% -drawer -width=40<CR><C-w>=
function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)j
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> m <Plug>(fern-action-mark-toggle)j
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" clever-f
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1

" vim-picker
let g:picker_height = 20
nmap <unique> <leader>f <Plug>(PickerEdit)
nmap <unique> <leader>ps <Plug>(PickerSplit)
nmap <unique> <leader>pt <Plug>(PickerTabedit)
nmap <unique> <leader>pv <Plug>(PickerVsplit)
nmap <unique> <leader>pb <Plug>(PickerBuffer)
nmap <unique> <leader>p] <Plug>(PickerTag)
nmap <unique> <leader>pw <Plug>(PickerStag)
nmap <unique> <leader>po <Plug>(PickerBufferTag)
nmap <unique> <leader>ph <Plug>(PickerHelp)

" vim-projectionist
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
map <leader>baa :A<CR>
nmap <leader>bav :AV<CR>
map <leader>bas :AS<CR>
map <leader>bat :AT<CR>

" neoterm
let g:neoterm_shell = '$SHELL -l'
let g:neoterm_size='80'
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_keep_term_open = 1
nnoremap <leader>tt :Ttoggle<CR>

" vim-grepper
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
" nmap gg <plug>(GrepperOperator)
" xmap gg <plug>(GrepperOperator)
nnoremap <leader>* :Grepper -tool rg -open -switch -cword -noprompt<cr>
nnoremap <Leader>// :GrepperRg<Space>
nnoremap <Leader>/w :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -tweb '$*'<cr>
nnoremap <Leader>/t :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -ttml '$*'<cr>
nnoremap <Leader>/s :Grepper -tool rg -open -switch -grepprg rg --with-filename --no-heading --smart-case --vimgrep -tsrc '$*'<cr>

" vim-qf
let &l:winheight = &lines / 3
let g:qf_max_height = 20
nmap <leader>gt <Plug>(qf_qf_toggle)

" undotree
let g:undotree_WindowLayout       = 4
let g:undotree_SetFocusWhenToggle = 1
nnoremap <Leader>u :UndotreeToggle<CR>

" vim-fugitive
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gl :Gclog %<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
