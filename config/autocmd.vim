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
