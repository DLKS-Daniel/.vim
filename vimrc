" ------------------------------
" Plugin Manager
" ------------------------------
call plug#begin('~/.vim/plugged')

" General Utilities
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" LSP
Plug 'yegappan/lsp'
Plug 'dense-analysis/ale'

call plug#end()

" ------------------------------
" General Settings
" ------------------------------
" --- Encoding & Files ---
set encoding=utf-8
set fileencoding=utf-8
set undofile
set noswapfile
set nobackup

" --- Display & UI ---
set number
set relativenumber
set laststatus=2
set signcolumn=yes
set nowrap
set scrolloff=15
set showmatch
set foldlevel=99
set pumheight=10

" --- Splits & Mouse ---
set splitbelow
set splitright
set mouse=a

" --- Search ---
set hlsearch incsearch ignorecase smartcase

" --- Command-line & Wildmenu ---
set completeopt=menuone,noselect
set wildmode=longest:full,full
set wildoptions=pum
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" --- Clipboard ---
set clipboard+=unnamed,unnamedplus

" --- Editing Behavior ---
set backspace=indent,eol,start
set hidden

" --- Performance ---
set lazyredraw
set shortmess+=c
set novisualbell
set noerrorbells
set t_vb=

" --- Syntax & Filetypes ---
syntax on
filetype plugin indent on

" --- Colorscheme ---
set t_Co=256
set termguicolors
set background=dark
set rtp+=~/.vim/colors/extras/vim
colorscheme tokyonight-moon

" ------------------------------
" Tabs & Indentation
" ------------------------------
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" ------------------------------
" Plugin Configurations
" ------------------------------
" --- VimWiki ---
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

" --- mucomplete ---
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = { 'default' : ['omni', 'keyn'] }

" --- LSP ---
let lspOptions = #{
    \ aleSupport: v:true,
    \ autoHighlight: v:true,
    \ completionTextEdit: v:true,
    \ noNewlineInCompletion: v:true,
    \ outlineOnRight: v:true,
    \ outlineWinSize: 70,
    \ showDiagWithSign: v:false,
    \ useQuickfixForLocations: v:true,
    \ }
autocmd VimEnter * call LspOptionsSet(lspOptions)

let lspServers = [
    \ #{ name: 'pylsp', filetype: ['py', 'python'], path: 'pylsp', args: []        },
\ ]
autocmd VimEnter * call LspAddServer(lspServers)

"Enable auto selection of the fist autocomplete item"
augroup LspSetup
    au!
    au User LspAttached set completeopt+=noselect
augroup END

"--- ALE settings ------------------------------------------------------"
"Disable ALE's LSP in favour of standalone LSP plugin"
let g:ale_disable_lsp = 1

"Show linting errors with highlights"
"* Can also be viewed in the loclist with :lope"
let g:ale_set_signs = 1
let g:ale_set_highlights = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_cursor = 'current'

"Define when to lint"
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_change = 'never'

"Set linters for individual filetypes"
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \ 'python': ['ruff', 'mypy', 'pylsp'],
\ }
"Specify fixers for individual filetypes"
let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['ruff'],
\ }
"Don't warn about trailing whitespace, as it is auto-fixed by '*' above"
let g:ale_warn_about_trailing_whitespace = 0
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"Show info, warnings, and errors; Write which linter produced the message"
let g:ale_lsp_show_message_severity = 'information'
let g:ale_echo_msg_format = '[%linter%] [%severity%:%code%] %s'
" See https://medium.com/@devsjc/from-jetbrains-to-vim-a-modern-vim-configuration-and-plugin-set-d58472a7d53d

"Mapping to run fixers on file"
nnoremap <leader>L :ALEFix<CR>

" ------------------------------
" Key Mappings
" ------------------------------
let mapleader = "\<Space>"

" --- File & Buffer Navigation ---
nnoremap <leader>s :e #<CR>
nnoremap <leader>S :sf<CR>
nnoremap <leader>q :bdelete<CR>
nnoremap <leader><leader> :ls<CR>:b<Space>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
nnoremap <C-w>e :enew<CR>
nnoremap <C-w>Q :qa<CR>

" --- Editing ---
nnoremap <leader>y :%y+<CR>
nnoremap <leader>dw :call StripTrailingWhitespaces()<CR>
nnoremap U <C-r>
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" --- View & UI ---
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" --- Git ---
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gl :Git log<CR><C-w>T

" --- Terminal / Run ---
nnoremap <C-f> q:
nnoremap <leader>t :shell<CR>
nnoremap <leader>p :!uv run %<CR>

" --- Search (ripgrep) ---
if executable('rg')
    command! -nargs=+ Rg call s:Ripgrep(<q-args>)
    function! s:Ripgrep(query)
        let l:rg_cmd = 'rg --vimgrep ' . shellescape(a:query)
        cexpr system(l:rg_cmd)
        copen
    endfunction
    nnoremap <leader>fg :Rg<Space>
endif

" --- Formatting ---
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
        execute '!black %'
        call winrestview(l:view)
    endfunction
    autocmd FileType python nnoremap <buffer> <leader>js :call FormatPythonWithBlack()<CR>
endif

" --- Build ---
autocmd FileType python compiler pylint
autocmd FileType json compiler jsonlint
autocmd FileType python,json nnoremap <buffer> <leader>l :make<CR>:copen<CR>

" --- Vimwiki Shortcuts ---
autocmd FileType vimwiki abbreviate cb - [ ]

" --- Visual Range Search ---
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" --- LSP Keybindings ---
nnoremap <silent> gd   :LspDefinition<CR>
nnoremap <silent> gD   :LspDeclaration<CR>
nnoremap <silent> gi   :LspImplementation<CR>
nnoremap <silent> gr   :LspReferences<CR>
nnoremap <silent> grn  :LspRename<CR>
nnoremap <silent> K    :LspHover<CR>
nnoremap <silent> <C-k> :LspSignatureHelp<CR>
nnoremap <silent> gca  :LspCodeAction<CR>
nnoremap <silent> <leader>f :LspDocumentFormat<CR>

" --- LSP Diagnostics ---
nnoremap <silent> gl   :LspDocumentDiagnostics<CR>
nnoremap <silent> [d   :LspPreviousDiagnostic<CR>
nnoremap <silent> ]d   :LspNextDiagnostic<CR>

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

" ------------------------------
" Autocommands
" ------------------------------
augroup toggle_relativenumber
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
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
" File I/O
" ------------------------------
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif

set viminfo='50,f1,<500,n~/.vim/viminfo
