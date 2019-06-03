scriptencoding utf-8

function! neuclr#java#Highlight() abort
  highlight! link javaAnnotation NeuBlue
  highlight! link javaDocTags NeuCyan
  highlight! link javaOperator NeuOrange
  highlight! link javaParen NeuFgH
  highlight! link javaParen1 NeuFgH
  highlight! link javaParen2 NeuFgH
  highlight! link javaParen3 NeuFgH
  highlight! link javaParen4 NeuFgH
  highlight! link javaParen5 NeuFgH
  highlight! link javaVarArg NeuGreen

  highlight! link javaCommentTitle Comment
endfunction
