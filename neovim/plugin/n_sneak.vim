scriptencoding utf-8

if exists('g:loaded_n_sneak')
  finish
endif

let g:loaded_n_sneak = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

map gs <Plug>Sneak_s
map gS <Plug>Sneak_S

let &cpoptions = s:save_cpo
unlet s:save_cpo
