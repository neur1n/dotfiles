scriptencoding utf-8

"************************************************************** Neur1n/neucs{{{
let b:palettes = {
      \ 'gruvbox': {
        \ 'bgh':    {'c': 234, 'g': '#1d2021'},
        \ 'bgm':    {'c': 235, 'g': '#282828'},
        \ 'bgs':    {'c': 236, 'g': '#32302f'},
        \ 'fgh':    {'c': 187, 'g': '#d5c4a1'},
        \ 'fgm':    {'c': 223, 'g': '#ebdbb2'},
        \ 'fgs':    {'c': 230, 'g': '#fbf1c7'},
        \ 'grayh':  {'c':  95, 'g': '#7c6f64'},
        \ 'graym':  {'c': 102, 'g': '#9a8374'},
        \ 'grays':  {'c': 138, 'g': '#a89984'},
        \ 'red':    {'c': 203, 'g': '#fb4934'},
        \ 'orange': {'c': 208, 'g': '#fe8019'},
        \ 'yellow': {'c': 214, 'g': '#fabd2f'},
        \ 'green':  {'c': 142, 'g': '#b8bb26'},
        \ 'cyan':   {'c': 108, 'g': '#8ec07c'},
        \ 'blue':   {'c': 108, 'g': '#83a598'},
        \ 'purple': {'c': 175, 'g': '#d3869b'}
        \ },
      \ 'gruvbox256': {
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
      \ }
call neucs#SetPalette(b:palettes)

let g:neucs_colorscheme = 'default'

colorscheme neucs
"}}}
