scriptencoding utf-8

function! neutil#qf#Clear() abort
  call setqflist([], 'r')
endfunction

function! neutil#qf#Toggle() abort
  if !exists('s:qf_opened')
    let l:winid = win_getid()
    execute 'botright copen'
    call win_gotoid(l:winid)
    let s:qf_opened = 1
    return
  endif

  if s:qf_opened
    execute 'cclose'
    let s:qf_opened = 0
  else
    let l:winid = win_getid()
    execute 'botright copen'
    call win_gotoid(l:winid)
    let s:qf_opened = 1
  endif
endfunction
