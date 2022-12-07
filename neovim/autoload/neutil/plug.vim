scriptencoding utf-8

function! neutil#plug#Loaded(name)
  return (
        \ has_key(g:plugs, a:name)
        \ && isdirectory(g:plugs[a:name].dir)
        \ && stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction
