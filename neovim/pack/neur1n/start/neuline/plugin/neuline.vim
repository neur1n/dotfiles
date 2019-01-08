scriptencoding utf-8

if exists('g:loaded_neuline')
  finish
endif
let g:loaded_neuline = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

augroup neuline
  autocmd!
  autocmd WinEnter,BufWinEnter,FileType,SessionLoadPost * call neuline#Update()
  autocmd BufUnload * call neuline#UpdateOnce()
  autocmd ColorScheme,SessionLoadPost * call parts#highlight#Link()
  if exists('g:loaded_neurun')
    autocmd User NeurunStart,NeurunFail,NeurunStop,NeurunClear call neuline#UpdateOnce()
  endif
augroup END

nmap <silent> <C-p> :call parts#lintinfo#Jump('prev')<cr>
nmap <silent> <C-n> :call parts#lintinfo#Jump('next')<cr>
nmap <silent> <leader>tw :call parts#whitespace#Trim()<cr>

let &cpoptions = s:save_cpo
unlet s:save_cpo
