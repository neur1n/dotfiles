" Vim syntax file
" Language:	general note, a extended tut(orial) file type
" Maintainer:	Jihang Li <LeeJihg@gmail.com>
" Last Change:	2017 January 9

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"=============================================================================== keyword
" Tag
" {dark text, orange background, bold}
syn keyword noteTag ERROR NOTE TODO UNKNOWN
syn keyword noteTag contained
hi noteTag guifg=#262626 guibg=#FFAF00 gui=bold
hi noteTag ctermfg=235 ctermbg=214 cterm=bold

" {gray text, green background, bold}
syn keyword noteActive ACTIVE
hi noteActive guifg=#585858 guibg=#87D700 gui=bold
hi noteActive ctermfg=240 ctermbg=112 cterm=bold

" {gray text, red background, bold}
syn keyword noteRemoved REMOVED
hi noteRemoved guifg=#585858 guibg=#FF5FAF gui=bold
hi noteRemoved ctermfg=240 ctermbg=205 cterm=bold

" HTTP link
" {dark text, blue background, bold}
syn keyword noteHttp http https
syn keyword noteHttp contained
hi noteHttp guifg=#262626 guibg=#00D7FF gui=bold
hi noteHttp ctermfg=235 ctermbg=45 cterm=bold

"=============================================================================== match
" Block
" {dark asterisk}
syn match noteBlock /^*.*/
hi noteBlock guifg=#808080
hi noteBlock ctermfg=244

" Comment
syn match noteComment /^#.*/ contains=noteTag,noteHttp
hi noteComment guifg=#666666
hi noteComment ctermfg=242

" Indicator
" {blue text}
syn match noteIndicator /^\<\(date\|game\|item\)\>\s/
hi noteIndicator guifg=#00D7FF
hi noteIndicator ctermfg=45

" Ignore Linux terminal command lines spelling checking
syn match noteCommand /^$.*/ contains=@NoSpell


let b:current_syntax = "note"
