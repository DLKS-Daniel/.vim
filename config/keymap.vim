" --- Keymaps ---
" Set space as leader key
let mapleader = " "
nnoremap <Space> <Nop>

" Leader + e: Open netrw in a minimal way
nnoremap <leader>e :Explore<CR>

" Buffers
nnoremap <silent> <leader>n  :bnext<CR>
nnoremap <silent> <leader>p :bprevious<CR>
nnoremap <silent> <leader>q :bdelete<CR>

" Pickers
nnoremap <silent> <leader><leader> :FuzzyBuffers<cr>
nnoremap <silent> <leader>ff :FuzzyFiles<cr>
nnoremap <silent> <leader>fh :FuzzyHelp<cr>
nnoremap <silent> <leader>fg :FuzzyGrep<cr>

" Vimrc
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :so<CR>

" Visual indenting
xnoremap < <gv
xnoremap > >gv

" Search in selected region
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Remove trailing whitespace characters
nnoremap <silent> <leader>dw :call StripTrailingWhitespaces()<CR>

" Term & Lazygit
nnoremap <leader>lg :!lazygit<CR>
nnoremap <leader>t :term<CR>
if exists(':tnoremap')
    tnoremap <ESC>   <C-\><C-n>
    tnoremap <silent> <C-W>q <C-\><C-n>:q!<CR>
endif
