" --- Keymaps ---
" Set space as leader key
let mapleader = " "

" nav
nnoremap <leader>s :e #<CR>
nnoremap <leader>S :sf #<CR>

" Yank buffer
nnoremap <leader>y :%y+<CR>

" Rm highlight
nnoremap <Esc> :nohl<CR>

" Indentation
nnoremap > >>g
nnoremap < <<g
xnoremap < <gv
xnoremap > >gv

" Undo
nnoremap U <C-r>

" Format JSON
nnoremap <leader>js mj:%!jq '.'<CR>'j

" Leader + e: Open netrw in a minimal way
nnoremap <leader>e :Explore<CR>

" Pickers
nnoremap <silent> <leader><leader> :FuzzyBuffers<cr>
nnoremap <silent> <leader>f :FuzzyFiles<cr>
nnoremap <silent> <leader>h :FuzzyHelp<cr>
nnoremap <silent> <leader>g :FuzzyGrep<cr>

" Vimrc
nnoremap <leader>. :edit $MYVIMRC<CR>
nnoremap <leader>r :so<CR>

" Search in selected region
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Remove trailing whitespace characters
nnoremap <silent> <leader>dw :call StripTrailingWhitespaces()<CR>

" Lazygit
nnoremap <leader>lg :!lazygit<CR>

" Term
nnoremap <leader>t :term<CR>
if exists(':tnoremap')
    tnoremap <ESC>   <C-\><C-n>
    tnoremap <silent> <C-W>q <C-\><C-n>:q!<CR>
endif
