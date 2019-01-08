scriptencoding utf-8

function! parts#vcs#Branch() abort
  if exists('g:loaded_gitbranch')
    return gitbranch#name() ==# '' ? '' : ' '.gitbranch#name()
  else
    return ''
  endif
endfunction
