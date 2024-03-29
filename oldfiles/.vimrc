set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set nu
set noswapfile
set nobackup
set smartcase
set undofile
set undodir=~/.vim/undodir
set nowrap
set nohlsearch
"set noshowmode
set hidden
set splitbelow
set splitright
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set signcolumn=yes
set updatetime=50

"split navigations
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Enable folding
set foldmethod=indent
set foldlevel=99

"Give more space for displaying messages
"set cmdheight=2

"Plug Starts
call plug#begin('~/.vim/plugged')


" Enable folding with the spacebar
"nnoremap <space> za
set scf

Plug 'tmhedberg/SimpylFold'

"Fugitive
Plug 'tpope/vim-fugitive'


"Auto-indent plugin(if ai does something wrong)
Plug 'vim-scripts/indentpython.vim'
set encoding=utf-8

Plug 'vim-syntastic/syntastic'

let python_highlight_all=1
syntax on

"Nerd Tree plugins
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'kien/ctrlp.vim'

"Powerline
"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"System Clipboard
set clipboard=unnamed

"Code-checker
Plug 'neomake/neomake'

"Multiple cursor editing
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Highlight the yank area
Plug 'machakann/vim-highlightedyank'

"auto-completion stuff"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1
Plug 'zchee/deoplete-jedi'
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'davidhalter/jedi-vim'
"Plug 'ervandew/supertab'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"endif

"Code formatter
Plug 'sbdchd/neoformat'

"fullscreen
Plug 'lambdalisue/vim-fullscreen'

"Colorscheme
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'altercation/solarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'ciaranm/inkpot'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-scripts/Zenburn'
Plug 'kyoz/purify'
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/sonokai'
Plug 'letorbi/vim-colors-modern-borland'

"Vim/devicons
Plug 'ryanoasis/vim-devicons'

"Telescope for nvim
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'

" VIM-POLYGLOT: A solid language pack for vim
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

"Airline as powerline
let g:airline_powerline_fonts = 1

"font
set guifont=CaskaydiaCove_NF:h13


"Autocompletions
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"Jedi
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"


"Enabling pylint
let g:neomake_python_enabled_makers = ['pylint']
"Automatic pylint (can be slow)
"call neomake#configure#automake('nrwi', 500)


"Colorscheme
set termguicolors
syntax enable
"set background=dark
"colorscheme gruvbox
"highlight Normal guibg=NONE
" The configuration options should be placed before `colorscheme sonokai`.
"        let g:sonokai_style = 'espresso'
"        let g:sonokai_better_performance = 1
"        colorscheme sonokai

let g:everforest_background = 'soft'
    let g:everforest_better_performance = 1
    colorscheme everforest
    "let g:airline.colorscheme = 'everforest'
"highlight Normal guibg=none
"hi EndOfBuffer guibg=none ctermbg=none
set incsearch
highlight ColorColumn ctermbg=0 guibg=lightgrey

"Specify python39 path

let g:python3_host_prog = "C:/Users/rajmo/AppData/Local/Programs/Python/Python39/python"

"Run Python code by pressing <F5> in insert mode
"imap <F5> <Esc>:w<CR>:!python % [filename.py]; <CR>
noremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ?  "\:NERDTreeFind<CR>" : "\:NERDTree<CR>" 
nmap <F5> <Esc>:w<CR>:!python %<CR>
nmap <F9> <Esc>:w <CR>:term python %<CR>
"Telescope remaps
let mapleader = " "
"nnoremap <leader>ps : lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
"

let g:deoplete#enable_at_startup = 1

