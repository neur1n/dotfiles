scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:startup = 1

function! neutbl#Update() abort
  let &tabline=s:Construct()
endfunction

function! s:Construct() abort
  return neutbl#wrapper#Part('left').'  '
        \ .neutbl#wrapper#Part('mid').'%='
        \ .neutbl#wrapper#Part('right')
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
