scriptencoding utf-8

if exists('g:loaded_neurun')
  finish
endif
let g:loaded_neurun = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

call neurun#highlight#Init()

nnoremap <silent> <leader>nr :call neurun#Run()<CR>
nnoremap <silent> <leader>ns :call neurun#Stop()<CR>
nnoremap <silent> <leader>nc :call neurun#qf#Clear()<CR>
nnoremap <silent> <leader>nv :call neurun#qf#Toggle()<CR>
nnoremap ZZ :call neurun#qf#Close()<CR>

command! -complete=file -nargs=+ Neurun call neurun#Run(<f-args>)

let &cpoptions = s:save_cpo
unlet s:save_cpo
