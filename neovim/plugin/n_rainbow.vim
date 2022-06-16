scriptencoding utf-8

if exists('g:loaded_n_rainbow')
  finish
endif

let g:loaded_n_rainbow = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:rainbow_active = 1

function! s:SetColors() abort
  if g:colors_name ==# 'neucs'
    let s:plt = neutil#plt#Get('current')
    let g:rainbow_conf = {
          \ 'ctermfgs': [s:plt.red.c, s:plt.orange.c, s:plt.green.c, s:plt.blue.c],
          \ 'guifgs': [s:plt.red.g, s:plt.orange.g, s:plt.green.g, s:plt.blue.g]
          \ }
  endif
endfunction

augroup n_rainbow
  autocmd!
  autocmd ColorScheme neucs call <SID>SetColors()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
