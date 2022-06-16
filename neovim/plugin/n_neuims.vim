scriptencoding utf-8

if exists('g:loaded_n_neuims')
  finish
endif

let g:loaded_n_neuims = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

if has('unix')
  let g:neuims = {
        \ 'im': 'English (US)',
        \ 'status': 0,
        \ 'keyboards': {
        \   'English (US)': 'xkb:us::eng',
        \   'Rime': 'rime',
        \ },
        \ }
endif

nnoremap <silent> <leader>it :call neuims#Toggle()<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo
