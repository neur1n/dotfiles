scriptencoding utf-8

function! neucs#diff#Highlight() abort
  highlight! link diffAdded NeuGreen
  highlight! link diffChanged NeuCyan
  highlight! link diffFile NeuYellow
  highlight! link diffLine NeuBlue
  highlight! link diffNewFile NeuOrange
  highlight! link diffRemoved NeuRed
endfunction
