scriptencoding utf-8

function! parts#wrapper#Part(part, active) abort
  if a:part ==# 'mode'
    let l:group = a:active ? '%#ZMode#' : '%#ZModeU#'
    return l:group.' %{parts#mode#Mode()} '
  elseif a:part ==# 'vcs'
    return '%#ZVCS#'.'%{parts#vcs#Branch()}'
  elseif a:part ==# 'bufinfo'
    let l:group = a:active ? '%#ZBufInfo#' : '%#ZBufInfoU#'
    return l:group.parts#bufinfo#Info()
  elseif a:part ==# 'modification'
    let l:group = a:active ? '%#ZModif#' : '%#ZModifU#'
    return l:group.parts#modification#Status()
  elseif a:part ==# 'windowswap'
    return '%#ZSwap#'.'%{parts#windowswap#Status()}'
  elseif a:part ==# 'tagbar'
    return '%#ZTag#'.'%{parts#tagbar#Tag()}'
  elseif a:part ==# 'fileinfo'
    return '%#ZFileInfo#'.parts#fileinfo#Info()
  elseif a:part ==# 'ruler'
    let l:group = a:active ? '%#ZRuler#' : '%#ZRulerU#'
    return l:group.parts#ruler#Info()
  elseif a:part ==# 'whitespace'
    return '%#ZWhitespace#'.'%{parts#whitespace#Next()}'
  elseif a:part ==# 'lintinfo'
    return '%#ZWarning#'.'%{parts#lintinfo#Info("W")}'
          \ .'%#ZError#'.'%{parts#lintinfo#Info("E")}'
  endif
endfunction
