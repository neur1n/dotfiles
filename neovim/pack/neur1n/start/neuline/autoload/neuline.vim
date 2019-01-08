scriptencoding utf-8

" Example:
" let g:neuline = {
"       \ 'bufinfo': ['num', ':', 'name'],
"       \ 'ruler': [4, -3],
"       \ }

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:startup = 1

function! neuline#Update() abort
  if s:startup
    set showtabline=2
    let &tabline=parts#tabline#Tabline()
    call s:Construct('active')
    call parts#highlight#Link('n')
    let s:startup = 0
  endif

  let l:winnr = winnr()
  let l:line = (winnr('$') == 1) ? [s:Construct('active')] :
        \ [s:Construct('active'), s:Construct('inactive')]
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', l:line[nr!=l:winnr])
    call setwinvar(nr, 'neuline', nr!=l:winnr)
  endfor
endfunction

function! neuline#UpdateOnce() abort
  if !exists('w:neuline') || w:neuline
    call neuline#Update()
  endif
endfunction

function! s:Construct(status) abort
  return s:LeftPart(a:status).'%='.s:RightPart(a:status).
        \ '%{parts#highlight#Link()}'
endfunction

function! s:LeftPart(status) abort
  if a:status ==# 'active'
    return parts#wrapper#Part('mode', 1)
          \ .parts#wrapper#Part('vcs', 1)
          \ .parts#wrapper#Part('bufinfo', 1)
          \ .parts#wrapper#Part('modification', 1)
          \ .parts#wrapper#Part('windowswap', 1)
  elseif a:status ==# 'inactive'
    " return parts#wrapper#Part('mode', 0)
    return parts#wrapper#Part('bufinfo', 0)
          \ .parts#wrapper#Part('modification', 0)
          \ .parts#wrapper#Part('windowswap', 0)
  endif
endfunction

function! s:RightPart(status) abort
  if a:status ==# 'active'
          " \ .parts#whitespace#next()
    return parts#wrapper#Part('tagbar', 1).'%<'
          \ .parts#wrapper#Part('fileinfo', 1)
          \ .parts#wrapper#Part('ruler', 1)
          \ .parts#wrapper#Part('lintinfo', 1)
  elseif a:status ==# 'inactive'
    return parts#wrapper#Part('ruler', 0)
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
