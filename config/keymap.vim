
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
nnoremap <leader><leader> :ls<Cr>:b<Space>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
autocmd FileType qf nnoremap <buffer> <C-n> :cnext<CR><C-w>w
autocmd FileType qf nnoremap <buffer> <C-p> :cprev<CR><C-w>w

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

" Map <leader>e to open netrw directory explorer like vinegar's '-'
nnoremap <leader>e :Explore<CR>

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
nnoremap <leader>g :Git<CR>

" --------------- --------------
" Terminal and cmd
" ------------------------------
nnoremap <leader>t :term<CR>
if exists(':tnoremap')
    tnoremap <ESC> <C-\><C-n>                    " Exit terminal mode
    tnoremap <silent> <C-W>q <C-\><C-n>:q!<CR>    " Close terminal
endif

nnoremap <C-f> q:
nnoremap <C-w>e :enew<CR>
