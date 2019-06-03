scriptencoding utf-8

function! neuclr#xml#Highlight() abort
  highlight! link docbkKeyword NeuCyanBold

  highlight! link dtdFunction NeuGrayM
  highlight! link dtdParamEntityPunct NeuGrayM
  highlight! link dtdParamEntityDPunct NeuGrayM
  highlight! link dtdTagName NeuPurple

  highlight! link xmlAttrib NeuCyan
  highlight! link xmlAttribPunct NeuGrayM
  highlight! link xmlCdataStart NeuGrayM
  highlight! link xmlCdataCdata NeuPurple
  highlight! link xmlDocTypeDecl NeuGrayM
  highlight! link xmlDocTypeKeyword NeuPurple
  highlight! link xmlEndTag NeuBlue
  highlight! link xmlEntity NeuOrange
  highlight! link xmlEntityPunct NeuOrange
  highlight! link xmlEqual NeuBlue
  highlight! link xmlProcessingDelim NeuGrayM
  highlight! link xmlTag NeuBlue
  highlight! link xmlTagName NeuBlue
endfunction
