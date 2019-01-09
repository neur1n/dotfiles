scriptencoding utf-8

let s:prev_mode = ''
let s:startup = 1
let s:link_map = {
      \ 'n':  'N',
      \ 'no': 'N',
      \ 'i':  'I',
      \ 'v':  'V',
      \ 'V':  'V',
      \ '': 'V',
      \ 'R':  'R',
      \ 'r':  'R',
      \ 'c':  'C',
      \ 't':  'C',
      \ }

"**************************************************************** Definition{{{
let s:palette = palette#Palette()
let s:color_map = {
      \ 'N': [s:palette.green, s:palette.cyan],
      \ 'I': [s:palette.cyan, s:palette.blue],
      \ 'V': [s:palette.yellow, s:palette.orange],
      \ 'R': [s:palette.purple, s:palette.blue],
      \ 'C': [s:palette.red, s:palette.cyan],
      \ }

function! s:HiStatic() abort
  " Tabline
  " call palette#Highlight('NLTLeft', s:palette.blue, 'bg', 'bold')
  " call palette#Highlight('NLTCurTab', s:palette.orange, 'bg', 'bold')
  " execute 'highlight link NLTNotCurTab NLTLeft'

  " Inactive mode and file info.
  call palette#Highlight('NSBufInfoU', s:palette.fgh, s:palette.bgh, 'bold')
  call palette#Highlight('NSModifU', s:palette.purple, s:palette.bgh, 'bold')
  call palette#Highlight('NSRulerU', s:palette.fgh, s:palette.bgh, 'NONE')

  call palette#Highlight('NSFileInfo', s:palette.gray, s:palette.bgh, 'NONE')

  " Plugin dependent.
  if exists('g:loaded_gitbranch')
    call palette#Highlight('NSVCS', s:palette.fgs, s:palette.bgh, 'bold')
  endif
  if exists('g:loaded_windowswap')
    call palette#Highlight('NSSwap', s:palette.orange, s:palette.bgh, 'bold')
  endif
  if exists(':Tagbar')
    call palette#Highlight('NSTag', s:palette.fgh, s:palette.bgh, 'italic')
  endif

  if exists('g:loaded_neomake') || exists('g:loaded_ale') || exists('g:did_coc_loaded')
    call palette#Highlight('NSWarning', s:palette.orange, s:palette.bgh, 'bold')
    call palette#Highlight('NSError', s:palette.red, s:palette.bgh, 'bold')
  endif
endfunction

function! s:HiDynamic(mode) abort
  call palette#Highlight('NSMode'.a:mode, s:palette.bgh, s:color_map[a:mode][0], 'bold')
  call palette#Highlight('NSBufInfo'.a:mode, s:color_map[a:mode][1], s:palette.bgh, 'bold')
  call palette#Highlight('NSModif'.a:mode, s:palette.red, s:palette.bgh, 'bold')
  call palette#Highlight('NSRuler'.a:mode, s:color_map[a:mode][0], s:palette.bgh, 'NONE')
endfunction
"}}}

"********************************************************************** Main{{{
function! neustl#highlight#Link(...) abort
  if s:startup
    call s:HiStatic()
    call s:HiDynamic('N')
    call s:HiDynamic('I')
    call s:HiDynamic('V')
    call s:HiDynamic('R')
    call s:HiDynamic('C')
    let s:startup = 0
  endif

  for w in range(1, winnr('$'))
    " if exists('w:inactive') && w:inactive == 1
    if w == winnr()
      let l:mode = get(s:link_map, a:0 ? a:1 : mode(), 'n')
      if l:mode == s:prev_mode
        return ''
      endif
      let s:prev_mode = l:mode

      execute 'highlight link NSMode NSMode'.l:mode
      execute 'highlight link NSBufInfo NSBufInfo'.l:mode
      execute 'highlight link NSModif NSModif'.l:mode
      execute 'highlight link NSRuler NSRuler'.l:mode
    endif
  endfor
  return ''
endfunction
"}}}
