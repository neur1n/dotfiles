" Vim syntax file
" Language:	tut(orial)
" Maintainer:	Jihang Li <LeeJihg@gmail.com>
" Last Change:	2016 May 21

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"=============================================================================== keyword
" Tags
syn keyword tutTag ERROR NOTE TODO
syn keyword tutTag contained
hi tutTag guifg=#262626 guibg=#FFAF00 gui=bold
hi tutTag ctermfg=235 ctermbg=214 cterm=bold

" Highlighting HTTP links
syn keyword tutHttp http https
syn keyword tutHttp contained
hi tutHttp guifg=#262626 guibg=#00D7FF gui=bold 
hi tutHttp ctermfg=235 ctermbg=45 cterm=bold

"=============================================================================== match
" Ignore Linux terminal command lines spelling checking
syn match tutCommand /$.*/ contains=@NoSpell

" Highlighting HTTP links
"syn match tutHttp /\(http\).*/ contains=@NoSpell
"hi def tutHttp guifg=#87CEFA

" Tags
"syn match tutTag /|.*|/ contained
"hi def tutTag guifg=#272822 guibg=#666666 gui=bold

" Comment style
syn match tutComment /#.*/ contains=tutTag,tutHttp
"contains=tutSections
hi tutComment guifg=#666666
hi tutComment ctermfg=242

let b:current_syntax = "tut"
