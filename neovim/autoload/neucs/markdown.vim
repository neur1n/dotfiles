scriptencoding utf-8

let s:plt = neucs#GetPalette()

function! neucs#markdown#Highlight() abort
  call neucs#html#Highlight()

  call neucs#Highlight('markdownItalic', s:plt.fgh, 'NONE', 'italic')
  call neucs#Highlight('markdownLinkText', s:plt.graym, 'none', 'underline')

  highlight! link markdownCode NeuCyan
  highlight! link markdownCodeBlock NeuCyan
  highlight! link markdownCodeDelimiter NeuCyan

  highlight! link markdownH1 NeuGreenBold
  highlight! link markdownH2 NeuGreenBold
  highlight! link markdownH3 NeuYellowBold
  highlight! link markdownH4 NeuYellowBold
  highlight! link markdownH5 NeuYellow
  highlight! link markdownH6 NeuYellow
  highlight! link markdownHeadingRule NeuGrayM

  highlight! link markdownHeadingDelimiter NeuOrange
  highlight! link markdownLinkDelimiter NeuFgH
  highlight! link markdownLinkTextDelimiter NeuFgH
  highlight! link markdownUrlDelimiter NeuFgS
  highlight! link markdownUrlTitleDelimiter NeuGreen

  highlight! link markdownBlockquote NeuGrayM
  highlight! link markdownListMarker NeuGrayM
  highlight! link markdownOrderedListMarker NeuGrayM
  highlight! link markdownRule NeuGrayM
  highlight! link markdownUrl NeuPurple

  highlight! link markdownIdDeclaration markdownLinkText
endfunction
