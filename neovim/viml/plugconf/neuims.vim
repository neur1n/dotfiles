scriptencoding utf-8

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
