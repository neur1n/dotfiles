scriptencoding utf-8

try
  let s:plt = neutil#palette#Palette()
catch /^Vim\%((\a\+)\)\=:E/
  finish
endtry

function! neuclr#html#Highlight() abort
  call neutil#palette#Highlight('htmlLink', s:plt.fgh, 'NONE', 'underline')
  call neutil#palette#Highlight('htmlBold', 'fg', 'bg', 'bold')
  call neutil#palette#Highlight('htmlBoldUnderline', 'fg', 'bg', 'bold,underline')
  call neutil#palette#Highlight('htmlBoldItalic', 'fg', 'bg', 'bold,italic')
  call neutil#palette#Highlight('htmlBoldUnderlineItalic', 'fg', 'bg', 'bold,italic,underline')
  call neutil#palette#Highlight('htmlItalic', 'fg', 'bg', 'italic')
  call neutil#palette#Highlight('htmlUnderline', 'fg', 'bg', 'underline')
  call neutil#palette#Highlight('htmlUnderlineItalic', 'fg', 'bg', 'italic,underline')

  highlight! link htmlArg NeuCyan
  highlight! link htmlEndTag NeuBlue
  highlight! link htmlScriptTag NeuPurple
  highlight! link htmlSpecialChar NeuOrange
  highlight! link htmlSpecialTagName NeuCyanBold
  highlight! link htmlTag NeuBlue
  highlight! link htmlTagN NeuFgS
  highlight! link htmlTagName NeuCyanBold
endfunction
