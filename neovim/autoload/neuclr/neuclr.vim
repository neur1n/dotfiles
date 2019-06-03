scriptencoding utf-8

function! neuclr#neuclr#Highlight() abort
  try
    execute printf('call neuclr#%s#Highlight()', &filetype)
  catch /^Vim\%((\a\+)\)\=:E/
    " echohl WarningMsg
    " echomsg '[neuclr] Unsupported filetype.'
    " echohl NONE
  endtry
endfunction
