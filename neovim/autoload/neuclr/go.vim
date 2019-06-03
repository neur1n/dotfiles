scriptencoding utf-8

function! neuclr#go#Highlight() abort
  highlight! link goBuiltins NeuOrange
  highlight! link goConstants NeuPurple
  highlight! link goDeclaration NeuRed
  highlight! link goDeclType NeuBlue
  highlight! link goDirective NeuCyan
endfunction
