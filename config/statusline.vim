" --- Visual ---
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \ 't'  : 'TERMINAL'
       \}

set statusline=
" Show current mode
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%2*

" Git status
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=\ %{GitStatus()}\ 

" File path, as typed or relative to current directory
set statusline+=\ %F

set statusline+=%{&modified?'\ [+]':''}
set statusline+=%{&readonly?'\ []':''}


" Separation point between left and right aligned items.
set statusline+=%=
set statusline+=%{&filetype!=#''?&filetype.'\ ':'none\ '}

" Encoding & Fileformat
set statusline+=%{&fileencoding!='utf-8'?'['.&fileencoding.']':''}
set statusline+=%2*
set statusline+=%-7([%{&fileformat}]%)
set statusline+=%1*

" Location of cursor line
set statusline+=[%l/%L]

" Column number
set statusline+=\ col:%2c
