scriptencoding utf-8

if exists('g:loaded_n_sneak')
  finish
endif

let g:loaded_n_sneak = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map s <Plug>Sneak_s
map S <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let &cpoptions = s:save_cpo
unlet s:save_cpo
