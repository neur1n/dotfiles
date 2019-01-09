scriptencoding utf-8

if exists('g:loaded_neutbl')
  finish
endif
let g:loaded_neutbl = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

set showtabline=2
call neutbl#highlight#Link()

augroup neutbl
  autocmd!
  autocmd WinEnter,BufUnload,BufWinEnter,FileType,SessionLoadPost * call neutbl#Update()
  autocmd ColorScheme,SessionLoadPost * call neutbl#highlight#Link()
  if exists('g:loaded_neurun')
    autocmd User NeurunAction call neutbl#Update() | call neutbl#highlight#Link()
  endif
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
