scriptencoding utf-8

let s:interrupt = 0

function! neurun#action#DoAutoCmd(cmd, ...) abort
  if a:0
    let s:interrupt = a:1
  else
    let s:interrupt = 0
  endif

  silent execute 'doautocmd User Neurun'.a:cmd
endfunction

function! neurun#action#IsInterrupted() abort
  return s:interrupt
endfunction
