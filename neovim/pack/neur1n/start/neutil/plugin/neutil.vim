scriptencoding utf-8

if exists('g:loaded_neutil')
  finish
endif
let g:loaded_neutil = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <leader>db :call general#DelHiddenBuf()<cr>
nnoremap <leader>ro :call general#ToggleReadOnly()<cr>
nnoremap <leader>rn :call general#ToggleRelLnr()<cr>

let &cpoptions = s:save_cpo
unlet s:save_cpo
