scriptencoding utf-8

let s:glyph_map = {'E': '✘', 'W': '', 'H': '', 'I': ''}
let s:type_map = {'E': 'error', 'W': 'warning', 'H': 'hint', 'I': 'information'}

"******************************************************************** Counts{{{
function! parts#lintinfo#Info(type) abort
  let l:cnt = 0
  if exists('g:loaded_neomake')
    let l:cnt = s:NeomakeInfo(a:type)
  elseif exists('g:did_coc_loaded')
    let l:cnt = s:CocInfo(a:type)
  endif
  if l:cnt > 0
    return s:glyph_map[a:type].l:cnt
  else
    return ''
  endif
endfunction

function! s:NeomakeInfo(type) abort
  let l:info = neomake#statusline#LoclistCounts()
  return get(l:info, a:type, 0)
endfunction

function! s:CocInfo(type) abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if !empty(l:info)
    return l:info[s:type_map[a:type]]
  else
    return 0
  endif
endfunction
"}}}

"********************************************************************** Jump{{{
function! parts#lintinfo#Jump(direction) abort
  if a:direction ==# 'prev'
    try
      silent execute 'lprevious'
    catch /^Vim\%((\a\+)\)\=:E/
      try
        silent execute 'llast'
      endtry
    endtry
  elseif a:direction ==# 'next'
    try
      silent execute 'lnext'
    catch /^Vim\%((\a\+)\)\=:E/
      try
        silent execute 'lfirst'
      endtry
    endtry
  endif
endfunction
"}}}
