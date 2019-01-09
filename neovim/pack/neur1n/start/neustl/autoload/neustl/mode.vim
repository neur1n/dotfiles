scriptencoding utf-8

let s:mode_map = {
      \ 'n':  'N',
      \ 'no': 'NO',
      \ 'i':  'I',
      \ 'v':  'V',
      \ 'V':  'VL',
      \ '': 'VB',
      \ 'R':  'R',
      \ 'r':  'PROMPT',
      \ 'c':  'C',
      \ 't':  'TERMINAL',
      \ 's':  'S',
      \ 'S':  'S',
      \ '': 'S',
      \ '__': '-',
      \ '?':  'UNKNOWN',
      \ }

function! neustl#mode#Mode() abort
  if &filetype ==# 'help'
    let l:mode = 'HELP'
  elseif &filetype ==# 'startify'
    let l:mode = 'STARTIFY'
  elseif &filetype ==# 'vim-plug'
    let l:mode = 'VIM-PLUG'
  else
    let l:mode = get(s:mode_map, mode(), '?')
  endif

  let l:mode .= &paste ? '|PASTE' : ''
  let l:mode .= &spell ? '|SPELL' : ''

  return l:mode
endfunction
