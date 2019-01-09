scriptencoding utf-8

function! neustl#ruler#Info() abort
  let l:format = get(g:, 'zipline.ruler', [4, -3])
  return printf('%%%dl/%%L:%%%dv', l:format[0], l:format[1])
endfunction
