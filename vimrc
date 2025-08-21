" =================
" Vim Configuration
" =================

" ------------------------------
" Plugin Manager (vim-plug)
" ------------------------------
call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'

call plug#end()


" ==========================================================
" GENERAL SETTINGS
" ==========================================================

" --- Encoding & File Management ---
set encoding=utf-8
set fileencoding=utf-8
set noswapfile
set nobackup

" --- Display & UI ---
set number
set relativenumber
set cursorline
set laststatus=2
set signcolumn=yes
set nowrap
set scrolloff=15
set showmatch
set foldlevel=99
set pumheight=10

" --- Windows, Splits & Mouse ---
set splitbelow
set splitright
set mouse=a

" --- Search ---
set hlsearch
set incsearch
set ignorecase
set smartcase

" --- Wildmenu & Completion ---
set completeopt=menuone,noselect
set wildmode=full
set wildoptions=pum
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" --- Clipboard ---
set clipboard=unnamed

" --- Behavior ---
set backspace=indent,eol,start
set hidden

" --- Performance ---
set shortmess+=c
set novisualbell
set noerrorbells
set t_vb=

" --- Syntax & Filetypes ---
syntax on
filetype plugin indent on

" --- Colorscheme ---
set termguicolors
set background=dark
colorscheme desert

" --- Data files ---
if has('persistent_undo')
    let &undodir = expand('~/.vim/undodir')
    call mkdir(&undodir, 'p', 0700)
    set undofile
endif
call mkdir(expand('~/.vim/history'), 'p')
set history=500
set viminfo='50,f1,<500,n~/.vim/viminfo

" --- Runtime Files ---
runtime! macros/matchit.vim
runtime! macros/man.vim

" ==========================================================
" INDENTATION & FORMATTING
" ==========================================================
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" ==========================================================
" PLUGIN CONFIGURATIONS
" ==========================================================

" --- Vimwiki ---
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

" --- Format JSON with jq ---
if executable('jq')
    function! FormatJSONWithJq()
        let l:view = winsaveview()
        silent %!jq '.'
        call winrestview(l:view)
    endfunction
    autocmd FileType json nnoremap <buffer> <leader>js :call FormatJSONWithJq()<CR>
endif

" --- Format Python with black ---
if executable('black')
    function! FormatPythonWithBlack()
        let l:view = winsaveview()
        execute '!black %'
        call winrestview(l:view)
    endfunction
    autocmd FileType python nnoremap <buffer> <leader>js :call FormatPythonWithBlack()<CR>
endif

" --- Python Build & Linting ---
let g:python_current_compiler = 'pylint'
function! TogglePythonCompiler()
    if g:python_current_compiler ==# 'pylint'
        let g:python_current_compiler = 'mypy'
    else
        let g:python_current_compiler = 'pylint'
    endif
    execute 'compiler ' . g:python_current_compiler
    echo 'Switched to ' . g:python_current_compiler
endfunction

" ==========================================================
" KEY MAPPINGS
" ==========================================================

" --- Leader ---
let mapleader = "\<Space>"


" --- File & Buffer ---
nnoremap <leader><leader> :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>q :call ConfirmBdelete()<CR>
nnoremap <leader>o :copen<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
nnoremap <C-w>e :enew<CR>
nnoremap <C-w>Q :qa<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <F2> :windo set ft=json<CR>

" --- Git ---
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gl :Git log<CR><C-w>T

" --- Clipboard & Editing ---
nnoremap <leader>y :%y+<CR>
nnoremap <leader>dw :call StripTrailingWhitespaces()<CR>
nnoremap U <C-r>
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv

" --- Move Lines ---
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" --- Misc ---
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" --- Python Specific ---
augroup PythonUvRun
  autocmd!
  autocmd FileType python nnoremap <buffer> <leader>p :!uv run %<CR>
augroup END

autocmd FileType vimwiki abbreviate cb - [ ]

" ==========================================================
" FUNCTIONS
" ==========================================================

" Confirm before closing buffer
function! ConfirmBdelete()
  if confirm("Are you sure you want to close this buffer?", "&Yes\n&No", 2) == 1
    bdelete!
  endif
endfunction

" Strip trailing whitespace
function! StripTrailingWhitespaces()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

" ==========================================================
" AUTOCOMMAND GROUPS
" ==========================================================

" Strip whitespace on save
augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * :call StripTrailingWhitespaces()
augroup END

" Quickfix navigation
augroup qf_mappings
    autocmd!
    autocmd FileType qf nnoremap <buffer> <C-n> :cnext<CR><C-w>w
    autocmd FileType qf nnoremap <buffer> <C-p> :cprev<CR><C-w>w
    autocmd FileType qf nnoremap <buffer> o <CR>
augroup END

" Disable default Vim message group
autocmd! vimHints
