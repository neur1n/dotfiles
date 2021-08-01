scriptencoding utf-8

" cornflower: 4f86f7
function! neutil#palette#Palette() abort
  let l:theme = 'neuron'

  if l:theme ==# 'gruvbox'
    return {
          \ 'bgh':    {'c': 234, 'g': '#1c1c1c'},
          \ 'bgm':    {'c': 235, 'g': '#262626'},
          \ 'bgs':    {'c': 236, 'g': '#303030'},
          \ 'fgh':    {'c': 222, 'g': '#ffd787'},
          \ 'fgm':    {'c': 223, 'g': '#ffd7af'},
          \ 'fgs':    {'c': 230, 'g': '#ffffd7'},
          \ 'grayh':  {'c': 237, 'g': '#3a3a3a'},
          \ 'graym':  {'c': 239, 'g': '#4e4e4e'},
          \ 'grays':  {'c': 241, 'g': '#626262'},
          \ 'red':    {'c': 203, 'g': '#ff5f5f'},
          \ 'orange': {'c': 208, 'g': '#ff8700'},
          \ 'yellow': {'c': 214, 'g': '#ffaf00'},
          \ 'green':  {'c': 142, 'g': '#afaf00'},
          \ 'cyan':   {'c': 108, 'g': '#87af87'},
          \ 'blue':   {'c': 109, 'g': '#87afaf'},
          \ 'purple': {'c': 175, 'g': '#d787af'}
          \ }
  elseif l:theme ==# 'neuron'
    return {
          \ 'bgh':    {'c': 234, 'g': '#151d1a'},
          \ 'bgm':    {'c': 235, 'g': '#212224'},
          \ 'bgs':    {'c': 236, 'g': '#30312e'},
          \ 'fgh':    {'c': 222, 'g': '#dad4c4'},
          \ 'fgm':    {'c': 223, 'g': '#e4dbcc'},
          \ 'fgs':    {'c': 230, 'g': '#e5e4df'},
          \ 'grayh':  {'c': 237, 'g': '#3c4041'},
          \ 'graym':  {'c': 239, 'g': '#4e5156'},
          \ 'grays':  {'c': 241, 'g': '#63696a'},
          \ 'red':    {'c': 167, 'g': '#dd6151'},
          \ 'orange': {'c': 215, 'g': '#ffac00'},
          \ 'yellow': {'c': 185, 'g': '#f2c700'},
          \ 'green':  {'c':  36, 'g': '#93c247'},
          \ 'cyan':   {'c': 108, 'g': '#69d0a5'},
          \ 'blue':   {'c': 152, 'g': '#5991ae'},
          \ 'purple': {'c':  99, 'g': '#d37ba2'}
          \ }
  endif
endfunction

function! neutil#palette#Highlight(group, fg, ...) abort
  " Arguments: group, fg, bg, sty, sp; fg and bg should be dict or str.
  if type(a:fg) == v:t_dict
    let l:fgc = a:fg.c
    let l:fgg = a:fg.g
  else
    let l:fgc = a:fg
    let l:fgg = a:fg
  endif

  if a:0 >= 1
    if type(a:1) == v:t_dict
      let l:bgc = a:1.c
      let l:bgg = a:1.g
    else
      let l:bgc = a:1
      let l:bgg = a:1
    endif
  else
    let l:bgc = 'NONE'
    let l:bgg = 'NONE'
  endif

  if a:0 >= 2
    let l:sty = a:2
  else
    let l:sty = 'NONE'
  endif

  let l:cmd = ['highlight', a:group, 'ctermfg='.l:fgc, 'ctermbg='.l:bgc,
        \ 'guifg='.l:fgg, 'guibg='.l:bgg, 'cterm='.l:sty, 'gui='.l:sty]

  if a:0 >= 3
    if type(a:3) == v:t_dict
      let l:sp = a:3.g
    else
      let l:sp = a:3
    endif
    call add(l:cmd, 'guisp='.l:sp)
  endif

  execute join(l:cmd, ' ')
endfunction
