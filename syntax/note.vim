" Vim syntax file
" Language:	general note for plain text
" Maintainer:	Jihang Li <LeeJihg@gmail.com>
" Last Change:	2017 Jan 13

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"=============================================================================== match
" Block
" {dark asterisk}
syn match noteBlock /^*.*/
"hi noteBlock guifg=#808080
"hi noteBlock ctermfg=244
hi noteBlock guifg=#3A3A3A
hi noteBlock ctermfg=237

" Ignore Linux terminal command lines spelling checking
"syn match noteCommand /^\$.*$/ contains=@NoSpell

" Comment
syn match noteComment /^\#.*/ contains=ALLBUT,noteBlock,noteCommand
hi noteComment guifg=#666666
hi noteComment ctermfg=242

"=============================================================================== delimit
syn match noteDelimite_1 /\[[A-Za-z0-9]\s/ conceal contained
syn match noteDelimite_2 /\]/ conceal contained
"syn match noteDelimite /\[[A-Za-z0-9]\]/ conceal contained

"=============================================================================== Capital Tags
" {dark text, blue box, bold}
syn match noteTagCapB /\[B.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagCapB guifg=#262626 guibg=#00D7FF gui=bold
hi noteTagCapB ctermfg=235 ctermbg=45 cterm=bold

" {dark text, green box, bold}
syn match noteTagCapG /\[G.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagCapG guifg=#262626 guibg=#87D700 gui=bold
hi noteTagCapG ctermfg=235 ctermbg=112 cterm=bold

" {dark text, orange box, bold}
syn match noteTagCapO /\[O.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
"syn match noteTagCapO /\[O\].*\s/me=e-1 contains=noteDelimite
hi noteTagCapO guifg=#262626 guibg=#FFAF00 gui=bold
hi noteTagCapO ctermfg=235 ctermbg=214 cterm=bold

" {dark text, purple box, bold}
syn match noteTagCapP /\[P.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagCapP guifg=#262626 guibg=#AF00FF gui=bold
hi noteTagCapP ctermfg=235 ctermbg=129 cterm=bold

" {dark text, red box, bold}
syn match noteTagCapR /\[R.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagCapR guifg=#262626 guibg=#FF5FAF gui=bold
hi noteTagCapR ctermfg=235 ctermbg=205 cterm=bold

"=============================================================================== Small Tags
" {blue text}
syn match noteTagSmlb /\[b.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlb guifg=#00D7FF
hi noteTagSmlb ctermfg=45

" {green text}
syn match noteTagSmlg /\[g.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlg guifg=#87D700
hi noteTagSmlg ctermfg=112

" {black text}
syn match noteTagSmlk /\[k.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlk guifg=#000000
hi noteTagSmlk ctermfg=0

" {orange text}
syn match noteTagSmlo /\[o.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlo guifg=#FFAF00
hi noteTagSmlo ctermfg=214
"
" {purple text}
syn match noteTagSmlp /\[p.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlp guifg=#AF00FF
hi noteTagSmlp ctermfg=129

" {red text}
syn match noteTagSmlr /\[r.\{-}\]/ contains=noteDelimite_1,noteDelimite_2 containedin=noteComment
hi noteTagSmlr guifg=#FF5FAF
hi noteTagSmlr ctermfg=205

"=============================================================================== region
" Include Programming Syntax Highlight
syn include @codeSnippet syntax/cpp.vim
syn region bugFunction start=+\/\/codebegin+ keepend end=+\/\/codeend+ contains=@codeSnippet
syn region bugDataType start=/</ end=/>/ contains=@codeSnippet


"=============================================================================== set behavior
" Set to read-only by default
setlocal ro

" Conceal highlighting controlling syntax
if has("conceal")
    setlocal cole=2 cocu=n
endif
"
"if has("conceal")
"    if has("ro")
"        setlocal cole=2 cocu=n
"    else
"        setlocal cole=2
"    endif
"endif

"if has("conceal")
"    "setlocal cole=2 cocu=nc
"    "setlocal cole=2 cocu=n
"    setlocal cole=2
"endif

let b:current_syntax = "note"
