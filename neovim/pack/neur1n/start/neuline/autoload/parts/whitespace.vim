scriptencoding utf-8

function! parts#whitespace#Next() abort
  let l:pos = searchpos('\v(\s+$)', 'cnw')

  if l:pos[0] == 0
    return ''
  else
    return printf('%s(%s%%{%d})', '', '', l:pos[0])
  endif
endfunction

function! parts#whitespace#Trim() abort
  execute '%s/\s\+$//g'
endfunction
