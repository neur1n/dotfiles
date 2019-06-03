scriptencoding utf-8

function! neuclr#netrw#Highlight() abort
  highlight! link netrwClassify NeuCyan
  highlight! link netrwCmdSep NeuFgS
  highlight! link netrwComment NeuGrayM
  highlight! link netrwDir NeuCyan
  highlight! link netrwExe NeuOrange
  highlight! link netrwHelpCmd NeuCyan
  highlight! link netrwLink NeuGrayM
  highlight! link netrwList NeuBlue
  highlight! link netrwSymLink NeuFgS
  highlight! link netrwVersion NeuGreen
endfunction
