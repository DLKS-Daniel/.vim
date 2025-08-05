" --- General Opts ---
syntax on
colorscheme desert
filetype plugin indent on
set t_Co=256
set nocompatible
set number
set relativenumber
set background=dark
set updatetime=800
set timeoutlen=500
set mouse=a
set laststatus=2
set signcolumn=yes
set splitbelow splitright
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard+=unnamed
set clipboard+=unnamedplus
set backspace=indent,eol,start
set nowrap
set foldlevel=99
set encoding=utf-8
set pumheight=10
set matchpairs=<:>,(:),[:],{:}
set novisualbell noerrorbells t_vb=
set hlsearch  " Highlight search results
set incsearch
set ignorecase
set smartcase
set wildmode=longest:full,full
set wildoptions=pum
set completeopt+=menuone,longest " Show menu even if there is only one item
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" --- Plugins ---
call plug#begin()

" Utils
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'Donaldttt/fuzzyy'
Plug 'vimwiki/vimwiki'

" LSP
Plug 'prabirshrestha/vim-lsp'

call plug#end()

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

source ~/.vim/config/io.vim
source ~/.vim/config/keymap.vim
source ~/.vim/config/autocmd.vim
source ~/.vim/config/lspconfig.vim


" Activate built-in plugins
runtime! macros/matchit.vim
runtime! ftplugin/man.vim
