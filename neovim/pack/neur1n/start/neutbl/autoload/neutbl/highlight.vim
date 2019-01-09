scriptencoding utf-8

let s:startup = 1
let s:link_map = {'h': 'Hint', 'i': 'Info', 'w': 'Warning', 'e': 'Error'}

function! neutbl#highlight#Link(...) abort
  if s:startup
    let l:palette = palette#Palette()
    call palette#Highlight('NTLeft', l:palette.blue, 'bg', 'bold')
    call palette#Highlight('NTCurTab', l:palette.orange, 'bg', 'bold')
    highlight link NTMid NONE
    highlight link NTNotCurTab NTLeft
    let s:startup = 0
  endif

  if exists('g:loaded_neurun')
    let l:group = get(s:link_map, neurun#status#Get('type'), 'i')
    execute 'highlight link NTMid NR'.l:group
  endif
endfunction
