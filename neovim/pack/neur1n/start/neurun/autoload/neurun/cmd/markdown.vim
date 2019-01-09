scriptencoding utf-8

function! neurun#cmd#markdown#Run() abort
  if has('unix')
    let l:browser = 'vivaldi'
  elseif has('win32')
    let l:browser = 'vivaldi'
  endif

  return [l:browser, bufname('%')]
endfunction
