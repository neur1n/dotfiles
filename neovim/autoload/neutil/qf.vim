scriptencoding utf-8

function! neutil#qf#Clear() abort
  call setqflist([], 'r')
  execute 'botright copen'
  execute 'wincmd p'
endfunction

function! neutil#qf#Toggle() abort
  if s:IsOpened()
    execute 'cclose'
  else
    execute 'botright copen'
    execute 'wincmd p'
  endif
endfunction


function! s:IsOpened() abort
  for l:nr in range(1, winnr('$'))
    if getwinvar(l:nr, '&filetype') ==# 'qf'
      return 1
    endif
  endfor
  return 0
endfunction
