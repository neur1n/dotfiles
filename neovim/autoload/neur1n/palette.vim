scriptencoding utf-8

"******************************************************************* {{{Gruvbox
" -= Dark mode =-
let s:gruvbox = {
      \ 'aqua':   ['#8ec07c', 108],
      \ 'blue':   ['#83a598', 109],
      \ 'green':  ['#b8bb26', 142],
      \ 'orange': ['#fe8019', 208],
      \ 'purple': ['#d3869b', 175],
      \ 'red':    ['#fb4934', 167],
      \ 'yellow': ['#fabd2f', 214],
      \ 'bg0_h':  ['#1d2021', 234],
      \ 'bg0':    ['#282828', 235],
      \ 'bg0_s':  ['#32302f', 236],
      \ 'fg0':    ['#fbf1c7', 229],
      \ 'fg1':    ['#ebdbb2', 223],
      \ 'gray':   ['#928374', 245],
      \ }
" }}}

"***************************************************************** {{{Solarized
" -= Dark mode =-
let s:solarized = {
      \ 'blue':    ['#268bd2', 32],
      \ 'cyan':    ['#2aa198', 36],
      \ 'green':   ['#859900', 106],
      \ 'orange':  ['#cb4b16', 166],
      \ 'magneta': ['#d33682', 168],
      \ 'red':     ['#dc322f', 160],
      \ 'violet':  ['#6c71c4', 62],
      \ 'yellow':  ['#b58900', 136],
      \ 'base03':  ['#002b36', 234],
      \ 'base02':  ['#073642', 235],
      \ 'base01':  ['#586e75', 242],
      \ 'base00':  ['#657b83', 66],
      \ 'base0':   ['#839496', 246],
      \ 'base1':   ['#93a1a1', 247],
      \ 'base2':   ['#eee8d5', 254],
      \ 'base3':   ['#fdf6e3', 230],
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

function! neur1n#palette#Highlight(group, tf, tb, gf, gb, sty) abort
  execute printf('highlight %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s cterm=%s gui=%s',
        \ a:group, a:tf, a:tb, a:gf, a:gb, a:sty, a:sty)
endfunction
