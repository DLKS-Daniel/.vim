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

if has('persistent_undo')
	set undodir=$HOME/.vim/history
	set undolevels=5000
	set undofile
endif

" Don't create swapfile
set noswapfile
set nobackup
