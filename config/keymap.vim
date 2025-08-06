
" ------------------------------
" Leader Key
" ------------------------------
let mapleader = " "

" ------------------------------
" Navigation & Buffers
" ------------------------------
nnoremap <leader>s :e #<CR>           " Reopen last file
nnoremap <leader>S :sf<CR>            " Split + open file
nnoremap <leader>q :bdelete<CR>       " Close current buffer

" ------------------------------
" Clipboard & Yank
" ------------------------------
nnoremap <leader>y :%y+<CR>           " Yank entire buffer to clipboard

" ------------------------------
" Visuals & UI
" ------------------------------
nnoremap <Esc> :nohl<CR>              " Clear search highlight

" ------------------------------
" Indentation
" ------------------------------
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv

" ------------------------------
" Undo & Redo
" ------------------------------
nnoremap U <C-r>                      " Redo

" ------------------------------
" JSON Formatting (requires jq)
" ------------------------------
nnoremap <leader>js mj:%!jq '.'<CR>'j " Format JSON using jq

" ------------------------------
" File Explorer (netrw)
" ------------------------------
nnoremap <leader>e :Explore<CR>

" ------------------------------
" Fuzzyy Pickers
" ------------------------------
nnoremap <silent> <leader><leader> :FuzzyBuffers<CR>
nnoremap <silent> <leader>f        :FuzzyFiles<CR>
nnoremap <silent> <leader>h        :FuzzyHelp<CR>
nnoremap <silent> <leader>g        :FuzzyGrep<CR>

" ------------------------------
" Vimrc Access
" ------------------------------
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" ------------------------------
" Visual Mode Search in Region
" ------------------------------
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" ------------------------------
" Trailing Whitespace Cleanup
" ------------------------------
nnoremap <silent> <leader>dw :call StripTrailingWhitespaces()<CR>

" ------------------------------
" Git Integration (LazyGit/Git)
" ------------------------------
nnoremap <leader>lg :Git<CR>

" ------------------------------
" Terminal
" ------------------------------
nnoremap <leader>t :term<CR>
if exists(':tnoremap')
    tnoremap <ESC> <C-\><C-n>                    " Exit terminal mode
    tnoremap <silent> <C-W>q <C-\><C-n>:q!<CR>    " Close terminal
endif
ndif
