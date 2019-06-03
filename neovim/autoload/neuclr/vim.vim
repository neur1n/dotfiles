scriptencoding utf-8

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

function! neuclr#vim#Highlight() abort
  call neutil#palette#Highlight('vimCommentTitle', s:plt.fgs, 'NONE', 'bold,italic')

  highlight! link vimBracket NeuOrange
  highlight! link vimContinue NeuFgS
  highlight! link vimFuncSID NeuFgS
  highlight! link vimMapModKey NeuOrange
  highlight! link vimNotation NeuOrange
  highlight! link vimSep NeuFgS
  highlight! link vimSetSep NeuFgS
endfunction
