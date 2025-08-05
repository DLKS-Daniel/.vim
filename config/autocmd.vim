" --- Autocmds ---
if !has('nvim')
    " Change cursor shapes based on whether we are in insert mode,
    let &t_SI = "\<esc>[6 q"
    let &t_EI = "\<esc>[2 q"
    if exists('&t_SR')
        let &t_SR = "\<esc>[4 q"
    endif
endif

" Do not use number and relative number for terminal inside nvim
if exists('##TermOpen')
    augroup term_settings
        autocmd!
        autocmd TermOpen * setlocal norelativenumber nonumber
        autocmd TermOpen * startinsert
    augroup END
endif

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

function! StripTrailingWhitespaces()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

augroup number_toggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END
