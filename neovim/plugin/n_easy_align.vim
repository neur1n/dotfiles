scriptencoding utf-8

if exists('g:loaded_n_easy_align')
  finish
endif

let g:loaded_n_easy_align = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

let &cpoptions = s:save_cpo
unlet s:save_cpo
