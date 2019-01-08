scriptencoding utf-8

let s:funclist = ['cwd', 'fcwd', 'rcwd', 'name', 'num']

function! parts#bufinfo#Info(...) abort
  " For example, ['num', ':', 'cwd', '/', 'name'] gives '1:parts/bufinfo.vim'.
  let l:bufinfo = ''
  " let l:format = get(g:, 'zipline.bufinfo', ['num', ':', 'name'])
  let l:format = a:0 ? a:1 : ['num', ':', 'name']

  for item in l:format
    if count(s:funclist, l:item)
      let l:bufinfo .= eval('s:'.item.'()')
    else
      let l:bufinfo .= item
    endif
  endfor

  return ' '.l:bufinfo
endfunction

function! s:cwd() abort
  " For example, if getcwd() gives '/foo/bar', then this gives 'bar'.
  return '%{expand{"%:p:h:t"}}'
endfunction

function! s:fcwd() abort
  return '%{getcwd()}'
  " return '%F'
endfunction

function! s:rcwd() abort
  " Relative path
  return '%f'
endfunction

function! s:name() abort
  return '%t'
endfunction

function! s:num() abort
  return '%n'
endfunction
