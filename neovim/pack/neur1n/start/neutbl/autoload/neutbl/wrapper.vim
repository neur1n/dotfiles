scriptencoding utf-8

let s:logo = glyph#Glyph('vim')

function! neutbl#wrapper#Part(part) abort
  if a:part ==# 'left'
    return '%#NTLeft# '.s:logo.' %<%{neutbl#left#Left()}'
  elseif a:part ==# 'mid'
    return neutbl#mid#Mid()
  elseif a:part ==# 'right'
    return '%#NTCurTab#'.'%{neutbl#right#CurrentTab()} '
          \ .'%#NTNotCurTab#'.'%{neutbl#right#NotCurrentTab()} '
          \ .'%999X%{neutbl#right#CloseButton()} '
  endif
endfunction
