scriptencoding utf-8

function! parts#wrapper#Part(part, active) abort
  if a:part ==# 'mode'
    let l:group = a:active ? '%#NLMode#' : '%#NLModeU#'
    return l:group.' %{parts#mode#Mode()} '
  elseif a:part ==# 'vcs'
    return '%#NLVCS#'.'%{parts#vcs#Branch()}'
  elseif a:part ==# 'bufinfo'
    let l:group = a:active ? '%#NLBufInfo#' : '%#NLBufInfoU#'
    return l:group.parts#bufinfo#Info()
  elseif a:part ==# 'modification'
    let l:group = a:active ? '%#NLModif#' : '%#NLModifU#'
    return l:group.parts#modification#Status()
  elseif a:part ==# 'windowswap'
    return '%#NLSwap#'.'%{parts#windowswap#Status()}'
  elseif a:part ==# 'tagbar'
    return '%#NLTag#'.'%{parts#tagbar#Tag()}'
  elseif a:part ==# 'fileinfo'
    return '%#NLFileInfo#'.parts#fileinfo#Info()
  elseif a:part ==# 'ruler'
    let l:group = a:active ? '%#NLRuler#' : '%#NLRulerU#'
    return l:group.parts#ruler#Info()
  elseif a:part ==# 'whitespace'
    return '%#NLWhitespace#'.'%{parts#whitespace#Next()}'
  elseif a:part ==# 'lintinfo'
    return '%#NLWarning#'.'%{parts#lintinfo#Info("W")}'
          \ .'%#NLError#'.'%{parts#lintinfo#Info("E")}'
  endif
endfunction
