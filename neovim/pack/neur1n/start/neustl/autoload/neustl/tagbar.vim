scriptencoding utf-8

function! neustl#tagbar#Tag() abort
  if exists(':Tagbar')
    let l:format = get(g:, 'zipline.tagbar', ['%s', '', '%f'])
    return tagbar#currenttag(l:format[0], l:format[1], l:format[2])
  else
    return ''
  endif
endfunction
