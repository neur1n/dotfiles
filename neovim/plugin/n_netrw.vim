scriptencoding utf-8

if exists('g:loaded_n_netrw')
  finish
endif

let g:loaded_n_netrw = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:netrw_browse_split=4                       " open file in previous window
let g:netrw_liststyle=3                         " set explorer to be tree style
let g:netrw_winsize=30                     " set explorer window width to be 30

let &cpoptions = s:save_cpo
unlet s:save_cpo
