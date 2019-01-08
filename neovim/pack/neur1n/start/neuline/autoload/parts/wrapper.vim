scriptencoding utf-8

function! parts#wrapper#Part(part, active) abort
  if a:part ==# 'mode'
    let l:group = a:active ? '%#NeuMode#' : '%#NeuModeU#'
    return l:group.' %{parts#mode#Mode()} '
  elseif a:part ==# 'vcs'
    return '%#NeuVCS#'.'%{parts#vcs#Branch()}'
  elseif a:part ==# 'bufinfo'
    let l:group = a:active ? '%#NeuBufInfo#' : '%#NeuBufInfoU#'
    return l:group.parts#bufinfo#Info()
  elseif a:part ==# 'modification'
    let l:group = a:active ? '%#NeuModif#' : '%#NeuModifU#'
    return l:group.parts#modification#Status()
  elseif a:part ==# 'windowswap'
    return '%#NeuSwap#'.'%{parts#windowswap#Status()}'
  elseif a:part ==# 'tagbar'
    return '%#NeuTag#'.'%{parts#tagbar#Tag()}'
  elseif a:part ==# 'fileinfo'
    return '%#NeuFileInfo#'.parts#fileinfo#Info()
  elseif a:part ==# 'ruler'
    let l:group = a:active ? '%#NeuRuler#' : '%#NeuRulerU#'
    return l:group.parts#ruler#Info()
  elseif a:part ==# 'whitespace'
    return '%#NeuWhitespace#'.'%{parts#whitespace#Next()}'
  elseif a:part ==# 'lintinfo'
    return '%#NeuWarning#'.'%{parts#lintinfo#Info("W")}'
          \ .'%#NeuError#'.'%{parts#lintinfo#Info("E")}'
  endif
endfunction
