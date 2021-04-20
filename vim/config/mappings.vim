nnoremap ; :
inoremap kj <Esc>
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
nmap <leader>a :Vista!!<CR>
nmap <leader>m :Marks<CR>
" nmap <leader>t :Vista finder<CR>
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

nnoremap <space>pl :Mlint<CR>
nnoremap <space>bl :Mlint %<CR>
