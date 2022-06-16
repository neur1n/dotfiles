scriptencoding utf-8

if exists('g:loaded_n_lexima')
  finish
endif

let g:loaded_n_lexima = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})

let &cpoptions = s:save_cpo
unlet s:save_cpo
