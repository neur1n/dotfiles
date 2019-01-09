scriptencoding utf-8

let s:status = {'msg': '', 'type': ''}

function! neurun#status#Status() abort
  if s:status.msg ==# ''
    let l:status = ''
  else
    let l:status = '[neurun] '.s:status.msg
  endif

  return l:status
endfunction

function! neurun#status#Get(...) abort
  if a:0
    if a:1 ==# 'msg'
      return s:status.msg
    elseif a:1 ==# 'type'
      return s:status.type
    endif
  else
      return s:status
  endif
endfunction

function! neurun#status#Set(msg, type) abort
  let s:status.msg = a:msg
  let s:status.type = a:type
endfunction
