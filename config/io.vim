" Directory specification and undo history
set viminfo='50,f1,<500,n~/.vim/viminfo
function! EnsureVimhisExists()
    let vimhis_path = expand('~/.vim/history')

    if !isdirectory(vimhis_path)
        call mkdir(vimhis_path, 'p')
        echo "Created directory: " . vimhis_path
    endif
endfunction
call EnsureVimhisExists()

" Set persistent undo
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile

" Don't create swapfile
set noswapfile
set nobackup
