scriptencoding utf-8

function! neutbl#mid#Mid() abort
  return '%#NTMid#'.'%{neurun#status#Status()}'
endfunction
