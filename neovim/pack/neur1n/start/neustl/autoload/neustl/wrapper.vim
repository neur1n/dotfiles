scriptencoding utf-8

function! neustl#wrapper#Part(part, active) abort
  if a:part ==# 'mode'
    let l:group = a:active ? '%#NSMode#' : '%#NSModeU#'
    return l:group.' %{neustl#mode#Mode()} '
  elseif a:part ==# 'vcs'
    return '%#NSVCS#'.'%{neustl#vcs#Branch()}'
  elseif a:part ==# 'bufinfo'
    let l:group = a:active ? '%#NSBufInfo#' : '%#NSBufInfoU#'
    return l:group.neustl#bufinfo#Info()
  elseif a:part ==# 'modification'
    let l:group = a:active ? '%#NSModif#' : '%#NSModifU#'
    return l:group.neustl#modification#Status()
  elseif a:part ==# 'windowswap'
    return '%#NSSwap#'.'%{neustl#windowswap#Status()}'
  elseif a:part ==# 'tagbar'
    return '%#NSTag#'.'%{neustl#tagbar#Tag()}'
  elseif a:part ==# 'fileinfo'
    return '%#NSFileInfo#'.neustl#fileinfo#Info()
  elseif a:part ==# 'ruler'
    let l:group = a:active ? '%#NSRuler#' : '%#NSRulerU#'
    return l:group.neustl#ruler#Info()
  elseif a:part ==# 'whitespace'
    return '%#NSWhitespace#'.'%{neustl#whitespace#Next()}'
  elseif a:part ==# 'lintinfo'
    return '%#NSWarning#'.'%{neustl#lintinfo#Info("W")}'
          \ .'%#NSError#'.'%{neustl#lintinfo#Info("E")}'
  endif
endfunction
