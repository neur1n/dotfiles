scriptencoding utf-8

function! neuclr#json#Highlight() abort
  highlight! link jsonBraces NeuFgM
  highlight! link jsonKeyword NeuGreen
  highlight! link jsonQuote NeuGreen
  highlight! link jsonString NeuFgM
endfunction
