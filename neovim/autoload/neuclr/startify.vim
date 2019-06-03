scriptencoding utf-8

function! neuclr#startify#Highlight() abort
  highlight! link StartifyBracket NeuFgM
  highlight! link StartifyFile NeuFgM
  highlight! link StartifyFooter NeuBgS
  highlight! link StartifyHeader NeuOrange
  highlight! link StartifyNumber NeuBlue
  highlight! link StartifyPath NeuGrayM
  highlight! link StartifySlash NeuGrayM
  highlight! link StartifySection NeuOrange
  highlight! link StartifySpecial NeuBgS
endfunction
