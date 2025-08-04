" --- General Opts ---
syntax on
colorscheme desert
filetype plugin indent on
set nocompatible
set number
set relativenumber
set background=dark
set updatetime=800
set timeoutlen=500
set mouse=a
set laststatus=2
set splitbelow splitright
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard+=unnamed
set clipboard+=unnamedplus
set backspace=indent,eol,start
set nowrap
set encoding=utf-8
set matchpairs=<:>,(:),[:],{:}
set novisualbell noerrorbells t_vb=
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" --- Plugins ---
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

Plug 'airblade/vim-gitgutter'
Plug 'Donaldttt/fuzzyy'
Plug 'vimwiki/vimwiki'

Plug 'natebosch/vim-lsc'

call plug#end()

let g:lsc_server_commands = {
  \ 'python': 'jedi-language-server',
  \ }
let g:lsc_auto_map = v:true

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

source ~/.vim/config/io.vim
source ~/.vim/config/keymap.vim
source ~/.vim/config/statusline.vim
source ~/.vim/config/menu.vim
source ~/.vim/config/autocmd.vim

" Activate built-in plugins
runtime! macros/matchit.vim
runtime! ftplugin/man.vim
