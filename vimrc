" ------------------------------
" Plugin Manager
" ------------------------------
call plug#begin('~/.vim/plugged')

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
Plug 'mattn/vim-lsp-settings'

call plug#end()

" ------------------------------
" General Settings
" ------------------------------
set encoding=utf-8
set t_Co=256
set termguicolors
set background=dark
set number
set relativenumber
set ruler
set laststatus=2
set signcolumn=yes
set splitbelow
set splitright
set mouse=a
set nowrap
set pumheight=10
set wildmode=longest:full,full
set wildoptions=pum
set clipboard+=unnamed,unnamedplus
set backspace=indent,eol,start
set showmatch
set foldlevel=99
set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set completeopt=menuone,noselect
set shortmess+=c
set novisualbell
set noerrorbells
set t_vb=
set undofile
set noswapfile
set nobackup
set viminfo='50,f1,<500,n~/.vim/viminfo

" Syntax & Filetypes
syntax on
filetype plugin indent on

" Colorscheme
set rtp+=~/.vim/colors/extras/vim
colorscheme tokyonight-moon

" ------------------------------
" Tab & Indentation
" ------------------------------
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" ------------------------------
" Plugin Configs
" ------------------------------
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]
let g:mucomplete#enable_auto_at_startup = 1

autocmd FileType * setlocal omnifunc=lsp#complete
let g:lsp_semantic_enabled = 1

" ------------------------------
" Key Mappings
" ------------------------------
let mapleader = " "

" File & Buffer Navigation
nnoremap <leader>s :e #<CR>
nnoremap <leader>S :sf<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <leader><leader> :ls<CR>:b<Space>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
nnoremap <C-w>e :enew<CR>

" Editing
nnoremap <leader>y :%y+<CR>
nnoremap <leader>dw :call StripTrailingWhitespaces()<CR>
nnoremap U <C-r>
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv

" View & UI
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" Search & Grep (Ripgrep)
if executable('rg')
    command! -nargs=+ Rg call s:Ripgrep(<q-args>)
    function! s:Ripgrep(query)
        let l:rg_cmd = 'rg --vimgrep ' . shellescape(a:query)
        cexpr system(l:rg_cmd)
        copen
    endfunction
    nnoremap <leader>g :Rg<Space>
endif

" Git
nnoremap <leader>gg :Git<CR>

" Formatting
if executable('jq')
    function! FormatJSONWithJq()
        let l:view = winsaveview()
        silent %!jq '.'
        call winrestview(l:view)
    endfunction
    autocmd FileType json nnoremap <buffer> <leader>js :call FormatJSONWithJq()<CR>
endif

if executable('black')
    function! FormatPythonWithBlack()
        let l:view = winsaveview()
        silent execute '!black %'
        call winrestview(l:view)
    endfunction
    autocmd FileType python nnoremap <buffer> <leader>bf :call FormatPythonWithBlack()<CR>
endif

" Terminal / Run
nnoremap <leader>t :terminal<CR>
nnoremap <C-f> q:
nnoremap <leader>p !uv run %<CR>

" Visual Mode Search in Range
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" LSP Keymaps (Neovim standard style)
nnoremap <silent> gd   :LspDefinition<CR>
nnoremap <silent> gD   :LspDeclaration<CR>
nnoremap <silent> gi   :LspImplementation<CR>
nnoremap <silent> gr   :LspReferences<CR>
nnoremap <silent> K    :LspHover<CR>
nnoremap <silent> <C-k> :LspSignatureHelp<CR>
nnoremap <silent> <leader>rn :LspRename<CR>
nnoremap <silent> <leader>ca :LspCodeAction<CR>
nnoremap <silent> <leader>f  :LspDocumentFormat<CR>

" Diagnostics
nnoremap <silent> gl  :LspDocumentDiagnostics<CR>
nnoremap <silent> [d  :LspPreviousDiagnostic<CR>
nnoremap <silent> ]d  :LspNextDiagnostic<CR>

" ------------------------------
" Functions
" ------------------------------
function! StripTrailingWhitespaces()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! EnsureVimhisExists()
    let vimhis_path = expand('~/.vim/history')
    if !isdirectory(vimhis_path)
        call mkdir(vimhis_path, 'p')
        echo "Created directory: " . vimhis_path
    endif
endfunction
call EnsureVimhisExists()

function! FormatJSONWithJq()
    let l:view = winsaveview()
    silent %!jq '.'
    call winrestview(l:view)
endfunction

" ------------------------------
" Autocommands
" ------------------------------
augroup toggle_relativenumber
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter *
        \ if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave *
        \ if &number | set norelativenumber | endif
augroup END

augroup resume_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * :call StripTrailingWhitespaces()
augroup END

augroup qf_mappings
    autocmd!
    autocmd FileType qf nnoremap <buffer> <C-n> :cnext<CR><C-w>w
    autocmd FileType qf nnoremap <buffer> <C-p> :cprev<CR><C-w>w
augroup END

augroup sync_syntax
    autocmd!
    autocmd BufEnter * syntax sync fromstart
augroup END

" ------------------------------
" Persistent Undo Directory
" ------------------------------
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif
