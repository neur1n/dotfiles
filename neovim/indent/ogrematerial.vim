if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent
setlocal indentexpr=OgreIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)

if exists("*OgreIndent")
  finish
endif

function! OgreIndent(lnum)
  let prevlinenum = prevnonblank(a:lnum-1)
  if prevlinenum == 0
    return 0
  endif

  let pl = substitute(getline(prevlinenum), '//.*$', '', '')
  let thisl = substitute(getline(a:lnum), '//.*$', '', '')
  let previ = indent(prevlinenum)

  let ind = previ

  if pl =~ '{\s*$'
    let ind += &sw
  endif

  if thisl =~ '^\s*}'
    let ind -= &sw
  endif

  return ind
endfunction
