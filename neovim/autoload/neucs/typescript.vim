scriptencoding utf-8

function! neucs#typescript#Highlight() abort
  highlight! link typeScriptAjaxMethods NeuFgS
  highlight! link typeScriptBraces NeuFgS
  highlight! link typeScriptDOMObjects NeuFgS
  highlight! link typeScriptEndColons NeuFgS
  highlight! link typeScriptFuncKeyword NeuCyan
  highlight! link typeScriptGlobalObjects NeuFgS
  highlight! link typeScriptHtmlElemProperties NeuFgS
  highlight! link typeScriptIdentifier NeuOrange
  highlight! link typeScriptInterpolationDelimiter NeuCyan
  highlight! link typeScriptLabel NeuCyan
  highlight! link typeScriptLogicSymbols NeuFgS
  highlight! link typeScriptNull NeuPurple
  highlight! link typeScriptOpSymbols NeuFgS
  highlight! link typeScriptParens NeuFgS
  highlight! link typeScriptReserved NeuCyan

  highlight! link typeScriptDocParam Comment
  highlight! link typeScriptDocSeeTag Comment
  highlight! link typeScriptDocTags Comment
endfunction
