scriptencoding utf-8

let s:plt = neucs#GetPalette()

function! neucs#vim#Highlight() abort
  call neucs#Highlight('vimCommentTitle', s:plt.fgs, 'NONE', 'bold,italic')

  highlight! link vimBracket NeuOrange
  highlight! link vimContinue NeuFgS
  highlight! link vimFuncSID NeuFgS
  highlight! link vimMapModKey NeuOrange
  highlight! link vimNotation NeuOrange
  highlight! link vimSep NeuFgS
  highlight! link vimSetSep NeuFgS
endfunction
