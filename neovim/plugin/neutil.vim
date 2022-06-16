scriptencoding utf-8

if exists('g:loaded_neutil')
  finish
endif

let g:loaded_neutil = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent> <Leader>dh :call neutil#buf#DeleteHidden()<CR>
nnoremap <silent> <Leader>ro :call neutil#buf#ToggleReadOnly()<CR>
nnoremap <silent> <Leader>ln :call neutil#buf#ToggleRelativeLineNumber()<CR>
nnoremap <silent> <Leader>tw :call neutil#buf#TrimTrailingWhitespace()<CR>
nnoremap <silent> <Leader>ts :call neutil#buf#TabToSpace()<CR>

nnoremap <silent> _ :call neutil#qf#Clear()<CR>
nnoremap <silent> + :call neutil#qf#Toggle()<CR>

augroup neutil
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && &buftype ==# 'quickfix' | q | endif
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
