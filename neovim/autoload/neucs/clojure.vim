scriptencoding utf-8

let s:plt = neucs#GetPalette()

function! neucs#clojure#Highlight() abort
  call neucs#Highlight('clojureRegexpCharClass', s:plt.fgh, 'NONE', 'bold')

  highlight! link clojureAnonArg NeuYellow
  highlight! link clojureCharacter NeuCyan
  highlight! link clojureCond NeuOrange
  highlight! link clojureDefine NeuYellow
  highlight! link clojureDeref NeuYellow
  highlight! link clojureException NeuRed
  highlight! link clojureFunc NeuYellow
  highlight! link clojureKeyword NeuBlue
  highlight! link clojureMacro NeuOrange
  highlight! link clojureMeta NeuYellow
  highlight! link clojureParen NeuFgH
  highlight! link clojureQuote NeuYellow
  highlight! link clojureRepeat NeuYellow
  highlight! link clojureSpecial NeuOrange
  highlight! link clojureStringEscape NeuCyan
  highlight! link clojureUnquote NeuYellow
  highlight! link clojureVariable NeuBlue

  highlight! link clojureRegexp NeuCyan
  highlight! link clojureRegexpEscape NeuCyan
  highlight! link clojureRegexpMod clojureRegexpCharClass
  highlight! link clojureRegexpQuantifier clojureRegexpCharClass
endfunction
