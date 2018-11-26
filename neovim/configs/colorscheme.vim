set guicursor+=a:blinkon0
set fillchars=vert:\|

hi! link SignColumn Normal

if g:colors_name ==# 'solarized'
    hi LineNr guibg=#002b36

    hi MatchParen ctermfg=168 ctermbg=NONE cterm=underline
        \ guifg=#d33682 guibg=NONE gui=bold,underline

    hi Search ctermfg=136 ctermbg=NONE cterm=bold,underline
        \ guifg=#b58900 guibg=NONE gui=bold,underline

    hi StatusLine guifg=#002b36 guibg=#2aa198 ctermfg=234 ctermbg=36
    hi StatusLineNC guifg=#1d2021 guibg=NONE ctermfg=234 ctermbg=NONE

    hi VertSplit guifg=#586e75 guibg=NONE
elseif g:colors_name ==# 'gruvbox'
    hi! ColorColumn guibg=#32302f ctermbg=236
    hi! CursorLine guibg=#32302f ctermbg=236
    hi! CursorLineNr guibg=#282828 ctermbg=235

    hi Search ctermfg=208 ctermbg=NONE cterm=bold,italic,underline
        \ guifg=#fe8019 guibg=NONE gui=bold,underline

    if get(g:, 'loaded_ale', 0)
        if get(g:, 'gruvbox_contrast_dark', 'medium') ==# 'soft'
            hi ALEErrorSign ctermfg=167 ctermbg=236 guifg=#fb4934 guibg=#32302f
            hi ALEWarningSign ctermfg=208 ctermbg=236 guifg=#fe8019 guibg=#32302f
        elseif get(g:, 'gruvbox_contrast_dark', 'medium') ==# 'medium'
            hi ALEErrorSign ctermfg=167 ctermbg=235 guifg=#fb4934 guibg=#282828
            hi ALEWarningSign ctermfg=208 ctermbg=235 guifg=#fe8019 guibg=#282828
        elseif get(g:, 'gruvbox_contrast_dark', 'medium') ==# 'hard'
            hi ALEErrorSign ctermfg=167 ctermbg=234 guifg=#fb4934 guibg=#1d2021
            hi ALEWarningSign ctermfg=208 ctermbg=234 guifg=#fe8019 guibg=#1d2021
        endif
    endif

    " hi StatusLine guifg=#002b36 guibg=#2aa198 ctermfg=234 ctermbg=36
    " hi StatusLineNC guifg=#1d2021 guibg=NONE ctermfg=234 ctermbg=NONE

    " hi VertSplit guifg=#586e75 guibg=NONE
endif

" hi lCursor guifg=NONE guibg=Cyan
" hi! link airline_tabfill LineNr
