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

" ------------------------------
" LSP Server Setup
" ------------------------------
" Python LSP: install via `pip install python-lsp-server`
if executable('pylsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" ------------------------------
" LSP Key Mappings
" ------------------------------
nnoremap <silent> gd   :LspDefinition<CR>
nnoremap <silent> gD   :LspDeclaration<CR>
nnoremap <silent> gi   :LspImplementation<CR>
nnoremap <silent> gT   :LspTypeDefinition<CR>
nnoremap <silent> K    :LspHover<CR>
nnoremap <silent> <C-k> :LspSignatureHelp<CR>
nnoremap <silent> gR   :LspReferences<CR>
nnoremap <silent> grn  :LspRename<CR>
nnoremap <silent> gf   :LspDocumentFormat<CR>
nnoremap <silent> ga   :LspCodeAction<CR>

" ------------------------------
" Viminfo: File history, registers, etc.
" ------------------------------
set viminfo='50,f1,<500,n~/.vim/viminfo  " Save file marks, registers, buffer list

" Ensure directory exists for additional history (custom location)
function! EnsureVimhisExists()
    let vimhis_path = expand('~/.vim/history')
    if !isdirectory(vimhis_path)
        call mkdir(vimhis_path, 'p')
        echo "Created directory: " . vimhis_path
    endif
endfunction
call EnsureVimhisExists()

" ------------------------------
" Persistent Undo
" ------------------------------
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile    " Enable persistent undo

" ------------------------------
" File Safety: Disable backup/swap
" ------------------------------
set noswapfile
set nobackup

" ------------------------------
" Improved vimgrep
" ------------------------------
command! -nargs=+ VGrep execute 'vimgrep /'.<q-args>.'/ **' | copen

" ------------------------------
" Cursor shape in terminal Vim
" ------------------------------
if !has('nvim')
    " Set cursor shape for different modes (Insert, Replace)
    let &t_SI = "\<Esc>[6 q"  " Insert mode - vertical bar
    let &t_EI = "\<Esc>[2 q"  " Normal mode - block
    if exists('&t_SR')
        let &t_SR = "\<Esc>[4 q"  " Replace mode - underline
    endif
endif

" ------------------------------
" Terminal-specific settings
" ------------------------------
if exists('##TermOpen')
    augroup terminal_settings
        autocmd!
        autocmd TermOpen * setlocal nonumber norelativenumber
        autocmd TermOpen * startinsert
    augroup END
endif

" ------------------------------
" Resume cursor position on reopen
" ------------------------------
augroup resume_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

" ------------------------------
" Strip trailing whitespace
" ------------------------------
function! StripTrailingWhitespaces()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

" ------------------------------
" Full syntax re-sync on buffer enter
" ------------------------------
augroup sync_syntax
    autocmd!
    autocmd BufEnter * syntax sync fromstart
augroup END

" ------------------------------
" Dynamic relative number toggle
" ------------------------------
augroup toggle_relativenumber
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter *
        \ if &number | set relativenumber | endif

    autocmd BufLeave,FocusLost,InsertEnter,WinLeave *
        \ if &number | set norelativenumber | endif
augroup END
