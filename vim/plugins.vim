call plug#begin('~/.vim/plugged')

if !has('nvim') && !exists('g:gui_oni') | Plug 'tpope/vim-sensible' | endif
Plug 'rstacruz/vim-opinion'

" commands
Plug 'wellle/targets.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'

" interface
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'andyl/vim-textobj-elixir'
Plug 'simeji/winresizer'

" theme
Plug 'joshdick/onedark.vim'

" " integrations
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'

" completions
Plug 'tpope/vim-endwise'

" languages
Plug 'elixir-editors/vim-elixir'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'

call plug#end()
