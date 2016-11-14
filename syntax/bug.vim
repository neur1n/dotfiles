" Vim syntax file
" Language:	bug logging
" Maintainer:	Jihang Li <LeeJihg@gmail.com>
" Last Change:	2016 July 22

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"=============================================================================== keyword
" Project Source
" {white text, purple background}
syn keyword bugSource GitHub
hi bugSource guifg=#FFFFFF guibg=#AF00FF gui=bold
hi bugSource ctermfg=15 ctermbg=129 cterm=bold

" Bug Recording Date
" {red text}
"syn keyword bugDate date
"hi bugDate guifg=#FF005F
"hi bugDate ctermfg=197

" Tag
" {white text, red background, bold}
syn keyword bugBug BUG
hi bugBug guifg=#585858 guibg=#FF5FAF gui=bold
hi bugBug ctermfg=240 ctermbg=205 cterm=bold

" {grey text, green background, bold}
syn keyword bugSolution SOLUTION SOL
hi bugSolution guifg=#585858 guibg=#87D700 gui=bold
hi bugSolution ctermfg=240 ctermbg=112 cterm=bold

" {grey text, orange background, bold}
syn keyword bugTodo TODO
hi bugTodo guifg=#585858 guibg=#FFAF00 gui=bold
hi bugTodo ctermfg=240 ctermbg=214 cterm=bold

"=============================================================================== match
" Project Title
" {dark text, orange background, bold}
syn match bugTitle /PROJECT.*/
hi bugTitle guifg=#262626 guibg=#5F87D7 gui=bold
hi bugTitle ctermfg=235 ctermbg=68 cterm=bold

" Bug Date & Location
" {blue text}
syn match bugLocation /^\<\(date\|library\|software\|hardware\)\>\s/
hi bugLocation guifg=#00D7FF
hi bugLocation ctermfg=45

" Block
" {dark asterisk}
syn match bugBlock /^*.*/
hi bugBlock guifg=#808080
hi bugBlock ctermfg=244

"=============================================================================== region
" Include Programming Syntax Highlight
syn include @codeSnippet syntax/cpp.vim
syn region bugFunction start=+\/\/codebegin+ keepend end=+\/\/codeend+ contains=@codeSnippet
syn region bugDataType start=/</ end=/>/ contains=@codeSnippet

"syn include @cppSnippet syntax/cpp.vim
"syn region bugcppFunction start=+\/\/cppbegin+ keepend end=+\/\/cppend+ contains=@cppSnippet
"syn region bugcppDataType start=/</ end=/>/ contains=@cppSnippet

let b:current_syntax = "bug"
