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
  hi! CursorLineNr guibg=bg ctermbg=bg

  hi Search ctermfg=208 ctermbg=NONE cterm=bold,italic,underline
        \ guifg=#fe8019 guibg=NONE gui=bold,underline

  if exists('g:loaded_neomake')
    hi NeomakeErrorSign ctermfg=167 ctermbg=bg guifg=#fb4934 guibg=bg
    hi NeomakeWarningSign ctermfg=208 ctermbg=bg guifg=#fe8019 guibg=bg
    hi link NeomakeInfoSign NeomakeWarningSign
    hi link NeomakeHintSign NeomakeWarningSign
  elseif exists('g:loaded_ale')
    hi ALEErrorSign ctermfg=167 ctermbg=bg guifg=#fb4934 guibg=bg
    hi ALEWarningSign ctermfg=208 ctermbg=bg guifg=#fe8019 guibg=bg
  elseif exists('g:did_coc_loaded')
    hi CocErrorSign ctermfg=167 ctermbg=bg guifg=#fb4934 guibg=bg
    hi CocWarningSign ctermfg=208 ctermbg=bg guifg=#fe8019 guibg=bg
    hi link CocInfoSign CocWarningSign
    hi link CocHintSign CocWarningSign
  endif

  hi StatusLine ctermfg=234 ctermbg=223 guifg=#1d2021 guibg=#ebdbb2
  hi StatusLineNC ctermfg=234 ctermbg=NONE guifg=#1d2021 guibg=NONE
endif
