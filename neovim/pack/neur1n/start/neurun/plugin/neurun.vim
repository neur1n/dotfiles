scriptencoding utf-8

if exists('g:loaded_neurun')
  finish
endif
let g:loaded_neurun = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent> <leader>nr :call neurun#Run()<CR>
nnoremap <silent> <leader>ns :call neurun#Stop()<CR>
nnoremap <silent> <leader>nc :call neurun#ClearQF()<CR>
nnoremap <silent> <leader>nv :call neurun#ToggleQF()<CR>
nnoremap ZZ :call neurun#CloseBuffer()<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
