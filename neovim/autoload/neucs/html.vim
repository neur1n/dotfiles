scriptencoding utf-8

let s:plt = neucs#GetPalette()

function! neucs#html#Highlight() abort
  call neucs#Highlight('htmlLink', s:plt.fgh, 'NONE', 'underline')
  call neucs#Highlight('htmlBold', 'fg', 'bg', 'bold')
  call neucs#Highlight('htmlBoldUnderline', 'fg', 'bg', 'bold,underline')
  call neucs#Highlight('htmlBoldItalic', 'fg', 'bg', 'bold,italic')
  call neucs#Highlight('htmlBoldUnderlineItalic', 'fg', 'bg', 'bold,italic,underline')
  call neucs#Highlight('htmlItalic', 'fg', 'bg', 'italic')
  call neucs#Highlight('htmlUnderline', 'fg', 'bg', 'underline')
  call neucs#Highlight('htmlUnderlineItalic', 'fg', 'bg', 'italic,underline')

  highlight! link htmlArg NeuCyan
  highlight! link htmlEndTag NeuBlue
  highlight! link htmlScriptTag NeuPurple
  highlight! link htmlSpecialChar NeuOrange
  highlight! link htmlSpecialTagName NeuCyanBold
  highlight! link htmlTag NeuBlue
  highlight! link htmlTagN NeuFgS
  highlight! link htmlTagName NeuCyanBold
endfunction
