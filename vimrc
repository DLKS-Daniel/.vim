call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive', { 'on': ['Git'] }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

call plug#end()

syntax on
filetype plugin indent on
set encoding=utf-8
set termguicolors
set background=dark
set rtp+=~/.vim/colors/tokyonight.nvim/extras/vim
colorscheme tokyonight-night

runtime! macros/matchit.vim macros/man.vim

set number
set relativenumber
set laststatus=2
set signcolumn=yes
set statusline=%<%f\ %=%l,%c
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set foldlevel=99
set foldmethod=manual
set pumheight=10
set completeopt=menuone,noselect
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmode=full
set wildoptions=pum
set wildignore+=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*/tmp/*,*.so,*.swp,*.zip,*.tar.gz,*/__pycache__/*
set ttyfast
set shortmess+=c
set noerrorbells
set novisualbell
set t_vb=
set mouse=a
if has('clipboard')
    set clipboard=unnamed
endif
set noswapfile
set nobackup
set hidden
set autoread
if has('persistent_undo')
    let &undodir = expand('~/.vim/undodir')
    call mkdir(&undodir, 'p', 0700)
    set undofile
endif
set history=50
set viminfo='50,f1,<50,n~/.vim/viminfo
set path+=**/*

let mapleader = "\<Space>"

nnoremap <leader><leader> :buffers<CR>
nnoremap <leader>f :find<Space>
nnoremap <leader>t q:
nnoremap <leader>r :call GrepPrompt()<CR>
nnoremap <leader>q :call ConfirmBdelete()<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>g :Git<CR>
nnoremap <leader>ww :VimwikiIndex<CR>
nnoremap <leader>y :%y+<CR>
nnoremap <leader>o :copen<CR>
nnoremap <leader>s :e #<CR>
nnoremap <leader>S :sf #<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap <C-w>e :enew<CR>
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <F2> :edit $MYVIMRC<CR>

nnoremap gl :Git log<CR><C-w>T
nnoremap U <C-r>
nnoremap > >>
nnoremap < <<
xnoremap < <gv
xnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

augroup qf_mappings
    autocmd!
    autocmd FileType qf nnoremap <buffer> <C-n> :cnext<CR><C-w>w
    autocmd FileType qf nnoremap <buffer> <C-p> :cprev<CR><C-w>w
augroup END

let g:vimwiki_list = [{
            \ 'path': '~/vimwiki/',
            \ 'syntax': 'markdown',
            \ 'ext': '.md' }]
autocmd FileType vimwiki abbreviate cb - [ ]
let g:highlightedyank_highlight_duration = 150

augroup python_setup
    autocmd!
    autocmd FileType python setlocal omnifunc=lsp#complete
    autocmd FileType python inoremap <C-n> <C-x><C-o>
    autocmd FileType python nnoremap <buffer> <silent> gd  :LspDefinition<CR>
    autocmd FileType python nnoremap <buffer> <silent> grr :LspReferences<CR>
    autocmd FileType python nnoremap <buffer> <silent> gi  :LspImplementation<CR>
    autocmd FileType python nnoremap <buffer> <silent> K   :LspHover<CR>
    autocmd FileType python nnoremap <buffer> <silent> grn :LspRename<CR>
    autocmd FileType python nnoremap <buffer> <silent> gca :LspCodeAction<CR>
    if executable('black')
        autocmd FileType python nnoremap <buffer> <leader>js :w<CR>:!black %<CR>
    endif
    autocmd FileType python nnoremap <buffer> <leader>p :!uv run %<CR>
augroup END

if executable('jq')
    autocmd FileType json nnoremap <buffer> <leader>js :w<CR>:%!jq '.'<CR>
endif

augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * :silent! call StripTrailingWhitespaces()
augroup END

function! ConfirmBdelete()
    if confirm("Delete this buffer?", "&Yes\n&No", 2) == 1
        bdelete!
    endif
endfunction

function! StripTrailingWhitespaces()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfunction

function! GrepPrompt()
  let pattern = input('Grep pattern: ')
  if empty(pattern)
    echo "No pattern provided, aborting."
    return
  endif
  execute 'vimgrep /' . pattern . '/ **'
  copen
endfunction

