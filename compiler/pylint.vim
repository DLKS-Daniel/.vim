if exists('current_compiler')
  finish
endif
let current_compiler = 'pylint'

" Use pylint with parseable format, no report (-r n), on current file (%)
setlocal makeprg=pylint\ -f\ parseable\ -r\ n\ %

" Errorformat: parseable pylint output
setlocal errorformat=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#,%-GNo%.%#
