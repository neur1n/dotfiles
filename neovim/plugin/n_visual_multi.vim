scriptencoding utf-8

if exists('g:loaded_n_visual_multi')
  finish
endif

let g:loaded_n_visual_multi = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'

let &cpoptions = s:save_cpo
unlet s:save_cpo
