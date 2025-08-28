call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'DLKS-Daniel/ctrlp.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-fugitive', { 'on': ['Git'] }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'jiangmiao/auto-pairs', { 'on': 'InsertEnter' }
Plug 'mattn/vim-lsp-settings', { 'on': ['BufReadPre'] }
Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }

call plug#end()

set encoding=utf-8
set noswapfile nobackup hidden autoread
set number relativenumber
set laststatus=2 signcolumn=yes nowrap scrolloff=10 showmatch
set foldlevel=99
set pumheight=5
set mouse=a
set lazyredraw ttyfast shortmess+=c
set noerrorbells novisualbell t_vb=
set hlsearch incsearch ignorecase smartcase
set completeopt=menuone,noselect
set wildmode=full wildoptions=pum
set wildignore+=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set backspace=indent,eol,start
set tabstop=4 shiftwidth=4 expandtab autoindent
syntax on
filetype plugin indent on
set termguicolors background=dark
set rtp+=~/.vim/colors/tokyonight.nvim/extras/vim
colorscheme tokyonight-night
if has('clipboard')
    set clipboard=unnamed
endif
if has('persistent_undo')
    let &undodir = expand('~/.vim/undodir')
    call mkdir(&undodir, 'p', 0700)
    set undofile
endif
call mkdir(expand('~/.vim/history'), 'p')
set history=500
set viminfo='50,f1,<500,n~/.vim/viminfo
runtime! macros/matchit.vim macros/man.vim

let mapleader = "\<Space>"
nnoremap <leader><leader> :CtrlPBuffer<CR>
nnoremap <leader>q :call ConfirmBdelete()<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>o :copen<CR>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>N :bprev<CR>
nnoremap <leader>g :Git<CR>
nnoremap <leader>ww :VimwikiIndex<CR>
nnoremap <leader>y :%y+<CR>
nnoremap <C-w>e :enew<CR>
nnoremap <C-w>t :tabnew<CR>
nnoremap <C-w>Q :qa<CR>
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <F2> :windo set ft=json<CR>
nnoremap gl :Git log<CR><C-w>T
nnoremap U <C-r>
nnoremap > >>g
nnoremap < <g
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
                \ foldmethod=expr
                \ foldexpr=lsp#ui#vim#folding#foldexpr()
                \ foldtext=lsp#ui#vim#folding#foldtext()
    autocmd FileType python inoremap <C-n> <C-x><C-o>
    autocmd FileType python nnoremap <buffer> <silent> gd  :LspDefinition<CR>
    autocmd FileType python nnoremap <buffer> <silent> gr  :LspReferences<CR>
    autocmd FileType python nnoremap <buffer> <silent> gi  :LspImplementation<CR>
    autocmd FileType python nnoremap <buffer> <silent> K   :LspHover<CR>
    autocmd FileType python nnoremap <buffer> <silent> grn :LspRename<CR>
    autocmd FileType python nnoremap <buffer> <silent> gca :LspCodeAction<CR>
    autocmd FileType python nnoremap <buffer> <silent> [d  :LspPreviousDiagnostic<CR>
    autocmd FileType python nnoremap <buffer> <silent> ]d  :LspNextDiagnostic<CR>
    if executable('black')
        autocmd FileType python nnoremap <buffer> <leader>js :!black %<CR>
    endif
    autocmd FileType python nnoremap <buffer> <leader>p :!uv run %<CR>
augroup END
if executable('jq')
    autocmd FileType json nnoremap <buffer> <leader>js :%!jq '.'<CR>
endif
augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * :silent! call StripTrailingWhitespaces()
augroup END
function! ConfirmBdelete()
    if confirm("Close this buffer?", "&Yes\n&No", 2) == 1
        bdelete!
    endif
endfunction
function! StripTrailingWhitespaces()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfunction
