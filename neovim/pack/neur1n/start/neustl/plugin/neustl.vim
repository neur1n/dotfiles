scriptencoding utf-8

if exists('g:loaded_neustl')
  finish
endif
let g:loaded_neustl = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

augroup neustl
  autocmd!
  autocmd WinEnter,BufWinEnter,FileType,SessionLoadPost * call neustl#Update()
  autocmd BufUnload * call neustl#UpdateOnce()
  autocmd ColorScheme,SessionLoadPost * call neustl#highlight#Link()
  if exists('g:loaded_neurun')
    autocmd User NeurunAction call neustl#UpdateOnce()
  endif
augroup END

nmap <silent> <C-p> :call neustl#lintinfo#Jump('prev')<cr>
nmap <silent> <C-n> :call neustl#lintinfo#Jump('next')<cr>
nmap <silent> <leader>tw :call neustl#whitespace#Trim()<cr>

let &cpoptions = s:save_cpo
unlet s:save_cpo
