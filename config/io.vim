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
