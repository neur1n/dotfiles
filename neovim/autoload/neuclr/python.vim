scriptencoding utf-8

function! neuclr#python#Highlight() abort
  highlight! link pythonBoolean NeuPurple
  highlight! link pythonBuiltin NeuYellow
  highlight! link pythonBuiltinFunc NeuYellow
  highlight! link pythonBuiltinObj NeuYellow
  highlight! link pythonCoding NeuBlue
  highlight! link pythonConditional NeuRed
  highlight! link pythonDecorator NeuRed
  highlight! link pythonDot NeuFgS
  highlight! link pythonDottedName NeuGreenBold
  highlight! link pythonException NeuRed
  highlight! link pythonExceptions NeuPurple
  highlight! link pythonFunction NeuCyan
  highlight! link pythonImport NeuBlue
  highlight! link pythonInclude NeuBlue
  highlight! link pythonRepeat NeuRed
  highlight! link pythonRun NeuBlue
  highlight! link pythonOperator NeuRed
endfunction
