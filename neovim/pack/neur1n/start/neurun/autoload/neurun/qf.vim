scriptencoding utf-8

let s:qfopened = 0

function! neurun#qf#Append(msg) abort
  call setqflist([{'text': '[reurun] '.a:msg}], 'a')
endf

function! neurun#qf#Clear() abort
  call setqflist([], 'r')
  call neurun#status#Set('', '')
  call neurun#action#DoAutoCmd('Action')
  " call neurun#action#DoAutoCmd('Clear')
endf

function! neurun#qf#Toggle() abort
  if s:qfopened
    execute 'cclose'
    let s:qfopened = 0
  else
    execute 'copen'
    let s:qfopened = 1
  endif
endfunction

function! neurun#qf#Close() abort
  if &buftype ==# 'quickfix' && winnr('$') != 1
    execute 'cclose'
    let s:qfopened = 0
  else
    execute 'x'
  endif
endf
