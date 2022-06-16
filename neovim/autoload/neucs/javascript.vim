scriptencoding utf-8

function! neucs#javascript#Highlight() abort
  highlight! link javaScriptBraces NeuFgM
  highlight! link javaScriptFunction NeuCyan
  highlight! link javaScriptIdentifier NeuRed
  highlight! link javaScriptMember NeuBlue
  highlight! link javaScriptNull NeuPurple
  highlight! link javaScriptNumber NeuPurple
  highlight! link javaScriptParens NeuFgH
endfunction
