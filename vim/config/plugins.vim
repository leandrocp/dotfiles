call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-sleuth'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'andyl/vim-textobj-elixir'
" Plug 'joshdick/onedark.vim'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'haishanh/night-owl.vim'
Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'chriskempson/base16-vim'
" Plug 'NLKNguyen/papercolor-theme'

Plug 'troydm/zoomwintab.vim'
" Plug 'scrooloose/nerdtree'
" Plug 'psliwka/vim-smoothie'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-projectionist'
Plug 'c-brenn/fuzzy-projectionist.vim'
Plug 'andyl/vim-projectionist-elixir'
" Plug 'kshenoy/vim-signature'
Plug 'janko/vim-test'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'tpope/vim-eunuch'
" Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'elixir-editors/vim-elixir'
Plug 'jgdavey/tslime.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-fugitive'
" Plug 'stefandtw/quickfix-reflector.vim'
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'wsdjeg/vim-fetch'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'andymass/vim-matchup'
Plug 'airblade/vim-rooter'
" Plug 'ruanyl/vim-gh-line'
" Plug 'dense-analysis/ale'

" Plug 'yggdroot/indentline'
" Plug 'simeji/winresizer'
" Plug 'itchyny/lightline.vim'
" Plug 'c-brenn/fuzzy-projectionist.vim'
" Plug 'tpope/vim-rhubarb'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'liuchengxu/vista.vim'
" Plug 'junegunn/vim-easy-align'

Plug 'lambdalisue/fern.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tmsvg/pear-tree'

call plug#end()

runtime! plugin/sensible.vim
runtime! plugin/opinion.vim
