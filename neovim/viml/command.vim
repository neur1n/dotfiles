scriptencoding utf-8

"******************************************************************* Editing{{{
command! ToggleSpell setlocal spell! spelllang=en_us
"}}}

"***************************************************************** Interface{{{
function! s:ToggleStatusline() abort
  if &laststatus == 2
    setlocal laststatus=3
  else
    setlocal laststatus=2
  endif
endfunction

command! ToggleStatusline call <SID>ToggleStatusline()
"}}}
