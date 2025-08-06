" ------------------------------
" General Settings
" ------------------------------
syntax on
filetype plugin indent on
set nocompatible
set encoding=utf-8
set t_Co=256
set background=dark
set termguicolors
set rtp+=~/.vim/colors/extras/vim
colorscheme tokyonight-moon

" UI & Usability
set number
set ruler
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
set backspace=2
set showmatch
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
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType * setlocal omnifunc=lsp#complete

set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c


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

let g:mucomplete#enable_auto_at_startup = 1

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
Plug 'lifepillar/vim-mucomplete'

" LSP
Plug 'prabirshrestha/vim-lsp'

call plug#end()

" ------------------------------
" Custom Configs & Runtime
" ------------------------------
source ~/.vim/config/io.vim
source ~/.vim/config/autocmd.vim
source ~/.vim/config/lspconfig.vim


" ------------------------------
" Mappings
" ------------------------------
let mapleader = " "

" Navigation & Buffers
nnoremap <leader>s :e #<CR>           " Reopen last file
nnoremap <leader>S :sf<CR>            " Split + open file
nnoremap <leader>q :bdelete<CR>       " Close current buffer
nnoremap <leader><leader> :ls<Cr>:b<Space>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
autocmd FileType qf nnoremap <buffer> <C-n> :cnext<CR><C-w>w
autocmd FileType qf nnoremap <buffer> <C-p> :cprev<CR><C-w>w

" Clipboard & Yank
nnoremap <leader>y :%y+<CR>           " Yank entire buffer to clipboard

" Visuals & UI
nnoremap <Esc> :nohl<CR>              " Clear search highlight

" Indentation
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv

" Undo & Redo
nnoremap U <C-r>                      " Redo

" JSON Formatting (requires jq)
nnoremap <leader>js mj:%!jq '.'<CR>'j " Format JSON using jq

" Map <leader>e to open netrw directory explorer like vinegar's '-'
nnoremap <leader>e :Explore<CR>

" Vimrc Access
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" Visual Mode Search in Region
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Trailing Whitespace Cleanup
nnoremap <silent> <leader>dw :call StripTrailingWhitespaces()<CR>

" Git Integration (LazyGit/Git)
nnoremap <leader>g :Git<CR>

" Terminal shell and cmd window
nnoremap <F1> :shell<CR>
nnoremap <C-f> q:
nnoremap <C-w>e :enew<CR>
