scriptencoding utf-8

"******************************************************************* {{{Gruvbox
" -= Dark mode =-
let s:gruvbox = {
      \ 'aqua':   {'c': 108, 'g': '#8ec07c'},
      \ 'blue':   {'c': 109, 'g': '#83a598'},
      \ 'green':  {'c': 142, 'g': '#b8bb26'},
      \ 'orange': {'c': 208, 'g': '#fe8019'},
      \ 'purple': {'c': 175, 'g': '#d3869b'},
      \ 'red':    {'c': 167, 'g': '#fb4934'},
      \ 'yellow': {'c': 214, 'g': '#fabd2f'},
      \ 'bg0_h':  {'c': 234, 'g': '#1d2021'},
      \ 'bg0':    {'c': 235, 'g': '#282828'},
      \ 'bg0_s':  {'c': 236, 'g': '#32302f'},
      \ 'fg0':    {'c': 229, 'g': '#fbf1c7'},
      \ 'fg1':    {'c': 223, 'g': '#ebdbb2'},
      \ 'gray':   {'c': 245, 'g': '#928374'},
      \ }
" }}}

"***************************************************************** {{{Solarized
" -= Dark mode =-
let s:solarized = {
      \ 'blue':    {'c':  32, 'g': '#268bd2'},
      \ 'cyan':    {'c':  36, 'g': '#2aa198'},
      \ 'green':   {'c': 106, 'g': '#859900'},
      \ 'orange':  {'c': 166, 'g': '#cb4b16'},
      \ 'magneta': {'c': 168, 'g': '#d33682'},
      \ 'red':     {'c': 160, 'g': '#dc322f'},
      \ 'violet':  {'c':  62, 'g': '#6c71c4'},
      \ 'yellow':  {'c': 136, 'g': '#b58900'},
      \ 'base03':  {'c': 234, 'g': '#002b36'},
      \ 'base02':  {'c': 235, 'g': '#073642'},
      \ 'base01':  {'c': 242, 'g': '#586e75'},
      \ 'base00':  {'c':  66, 'g': '#657b83'},
      \ 'base0':   {'c': 246, 'g': '#839496'},
      \ 'base1':   {'c': 247, 'g': '#93a1a1'},
      \ 'base2':   {'c': 254, 'g': '#eee8d5'},
      \ 'base3':   {'c': 230, 'g': '#fdf6e3'},
      \ }
" }}}

function! neur1n#palette#Palette() abort
  if g:colors_name ==# 'gruvbox'
    let l:palette = {
          \ 'fg_h':   s:gruvbox.fg1,
          \ 'fg_s':   s:gruvbox.fg0,
          \ 'bg_h':   s:gruvbox.bg0_h,
          \ 'bg_s':   s:gruvbox.bg0_s,
          \ 'gray':   s:gruvbox.gray,
          \ 'red':    s:gruvbox.red,
          \ 'orange': s:gruvbox.orange,
          \ 'yellow': s:gruvbox.yellow,
          \ 'green':  s:gruvbox.green,
          \ 'cyan':   s:gruvbox.aqua,
          \ 'blue':   s:gruvbox.blue,
          \ 'purple': s:gruvbox.purple,
          \ }
  elseif g:colors_name ==# 'solarized'
    let l:palette = {
          \ 'fg_h':   s:solarized.base2,
          \ 'fg_s':   s:solarized.base1,
          \ 'bg_h':   s:solarized.base03,
          \ 'bg_s':   s:solarized.base01,
          \ 'gray':   s:solarized.gray,
          \ 'red':    s:solarized.red,
          \ 'orange': s:solarized.orange,
          \ 'yellow': s:solarized.yellow,
          \ 'green':  s:solarized.green,
          \ 'cyan':   s:solarized.cyan,
          \ 'blue':   s:solarized.blue,
          \ 'purple': s:solarized.violet,
          \ }
  endif

  return l:palette
endfunction

function! neur1n#palette#Highlight(group, fg, bg, sty) abort
  if type(a:fg) == v:t_dict
    let l:fgc = a:fg.c
    let l:fgg = a:fg.g
  else
    let l:fgc = a:fg
    let l:fgg = a:fg
  endif

  if type(a:bg) == v:t_dict
    let l:bgc = a:bg.c
    let l:bgg = a:bg.g
  else
    let l:bgc = a:bg
    let l:bgg = a:bg
  endif

  execute printf('highlight %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s cterm=%s gui=%s',
        \ a:group, l:fgc, l:bgc, l:fgg, l:bgg, a:sty, a:sty)
endfunction
