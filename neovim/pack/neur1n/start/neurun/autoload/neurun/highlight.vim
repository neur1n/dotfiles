scriptencoding utf-8

" let s:startup = 1

function! neurun#highlight#Init() abort
  let l:palette = palette#Palette()
  call palette#Highlight('NRInfo', l:palette.blue, 'bg', 'bold')
  call palette#Highlight('NRHint', l:palette.green, 'bg', 'bold')
  call palette#Highlight('NRWarning', l:palette.yellow, 'bg', 'bold')
  call palette#Highlight('NRError', l:palette.red, 'bg', 'bold')
endfunction
