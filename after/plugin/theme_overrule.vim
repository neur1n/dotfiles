set guicursor+=a:blinkon0
set fillchars=vert:\|

if g:colors_name == 'solarized'
    hi LineNr guibg=#002B36
    hi MatchParen ctermfg=197 ctermbg=NONE cterm=underline guifg=#F92672 guibg=NONE gui=underline,bold
    hi Search ctermfg=0 ctermbg=14 cterm=reverse guifg=#FF79C6 gui=italic,underline
    hi VertSplit guifg=#808080 guibg=#002B36
endif

" hi SignColumn guibg=#002B36  " 063642
" hi lCursor guifg=NONE guibg=Cyan
" hi! link airline_tabfill LineNr
