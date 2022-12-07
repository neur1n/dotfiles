scriptencoding utf-8

if exists('g:loaded_n_leap')
  finish
endif

let g:loaded_n_leap = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap f <Plug>(leap-forward-to)
nnoremap F <Plug>(leap-backward-to)

let &cpoptions = s:save_cpo
unlet s:save_cpo
