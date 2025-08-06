" ------------------------------
" General Settings
" ------------------------------
syntax on
filetype plugin indent on
colorscheme desert
set nocompatible
set encoding=utf-8
set t_Co=256
set background=dark

" UI & Usability
set number
set cursorline
set relativenumber
set laststatus=2
set signcolumn=yes
set splitbelow
set splitright
set mouse=a
set nowrap
set pumheight=10
set updatetime=800
set timeoutlen=500
set wildmode=longest:full,full
set wildoptions=pum
set clipboard+=unnamed,unnamedplus
set backspace=indent,eol,start
set matchpairs+=<:>,(:),[:],{:}
set foldlevel=99
set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden              " Allow switching from unsaved buffers

" Editing
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Search & Completion
set completeopt=menuone,longest
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType * setlocal omnifunc=lsp#complete

" Misc
set novisualbell
set noerrorbells
set t_vb=

" VimWiki
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

" ------------------------------
" Plugins (via vim-plug)
" ------------------------------
call plug#begin()

" General Utilities
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'

" LSP
Plug 'prabirshrestha/vim-lsp'

call plug#end()

" ------------------------------
" Custom Configs & Runtime
" ------------------------------
source ~/.vim/config/io.vim
source ~/.vim/config/keymap.vim
source ~/.vim/config/autocmd.vim
source ~/.vim/config/lspconfig.vim

runtime! macros/matchit.vim
runtime! ftplugin/man.vim
