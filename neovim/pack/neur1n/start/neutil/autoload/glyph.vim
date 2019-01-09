scriptencoding utf-8

" Must use double quotes to wrap unicode codes.
" Most of the names follow those on https://nerdfonts.com/#cheat-sheet.

" Candidates:
" ["\ue62b", '']
" ["\ufb2b", 'שׂ']
" ["\uf83d", '']
" ["\uf023", '']
" ["\uf456", '']
" ["\uf8e9", '']
" ["\uf8ea", '']
" ["\u039e", 'Ξ']
" ["\uf0e7", '']
" ["\u2573", '╳']
" ["\ue009", '']

let s:glyph = {
\          'bang':     ["\uf12a", ''],
\          'branch':   ["\ue0a0", ''],
\          'check':    ["\u2713", '✓'],
\          'close':    ["\uf00d", ''],
\          'cnum':     ["\ue0a3", ''],
\          'error':    ["\u2718", '✘'],
\          'hint':     ["\uf834", ''],
\          'info':     ["\uf129", ''],
\          'linux':    ["\uf17c", ''],
\          'lnum':     ["\ue0a1", ''],
\          'modified': ["\uf040", ''],
\          'mac':      ["\ue711", ''],
\          'question': ["\uf128", ''],
\          'readonly': ["\ue0a2", ''],
\          'stop':     ["\uf04d", ''],
\          'vim':      ["\ue7c5", ''],
\          'warning':  ["\uf740", ''],
\          'win':      ["\uf17a", ''],
\          'wspc':     ["\ue612", ''],
\ }

function! glyph#Glyph(name, ...)
    if a:0 == 0
        return s:glyph[a:name][0]
    else
        return s:glyph[a:name][a:1]
    endif
endfunction
