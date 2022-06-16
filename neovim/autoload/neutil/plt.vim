scriptencoding utf-8

let s:current = 'random'

let s:schemes = {
      \ 'clack': {
      \   'bgh':     {'c': 234, 'g': '#16161d'},
      \   'bgm':     {'c': 235, 'g': '#1f1f2a'},
      \   'bgs':     {'c': 236, 'g': '#292937'},
      \   'fgh':     {'c': 230, 'g': '#faebd7'},
      \   'fgm':     {'c': 231, 'g': '#fafafa'},
      \   'fgs':     {'c': 231, 'g': '#fffff0'},
      \   'grayh':   {'c': 238, 'g': '#464646'},
      \   'graym':   {'c': 239, 'g': '#4e4e4e'},
      \   'grays':   {'c':  59, 'g': '#5f5f5f'},
      \   'red':     {'c': 167, 'g': '#dd6151'},
      \   'orange':  {'c': 214, 'g': '#ffac00'},
      \   'yellow':  {'c': 220, 'g': '#f2c700'},
      \   'green':   {'c': 107, 'g': '#93c247'},
      \   'cyan':    {'c':  79, 'g': '#69d0a5'},
      \   'blue':    {'c':  67, 'g': '#5991ae'},
      \   'purple':  {'c': 175, 'g': '#d37ba2'},
      \   'special': {'c':  69, 'g': '#4f86f7'}
      \ },
      \ 'gruvbox': {
      \   'bgh':     {'c': 234, 'g': '#1d2021'},
      \   'bgm':     {'c': 235, 'g': '#282828'},
      \   'bgs':     {'c': 236, 'g': '#32302f'},
      \   'fgh':     {'c': 187, 'g': '#d5c4a1'},
      \   'fgm':     {'c': 223, 'g': '#ebdbb2'},
      \   'fgs':     {'c': 230, 'g': '#fbf1c7'},
      \   'grayh':   {'c':  95, 'g': '#7c6f64'},
      \   'graym':   {'c': 244, 'g': '#928374'},
      \   'grays':   {'c': 138, 'g': '#a89984'},
      \   'red':     {'c': 203, 'g': '#fb4934'},
      \   'orange':  {'c': 208, 'g': '#fe8019'},
      \   'yellow':  {'c': 214, 'g': '#fabd2f'},
      \   'green':   {'c': 142, 'g': '#b8bb26'},
      \   'cyan':    {'c': 108, 'g': '#8ec07c'},
      \   'blue':    {'c': 108, 'g': '#83a598'},
      \   'purple':  {'c': 175, 'g': '#d3869b'},
      \   'special': {'c':  69, 'g': '#4f86f7'}
      \ },
      \ 'iceberg': {
      \   'bgh':     {'c': 233, 'g': '#0f1117'},
      \   'bgm':     {'c': 234, 'g': '#161822'},
      \   'bgs':     {'c': 235, 'g': '#1e2132'},
      \   'fgh':     {'c': 252, 'g': '#c7c9d1'},
      \   'fgm':     {'c': 255, 'g': '#d2d4de'},
      \   'fgs':     {'c': 188, 'g': '#e8e9ec'},
      \   'grayh':   {'c': 239, 'g': '#3e445e'},
      \   'graym':   {'c': 240, 'g': '#444b71'},
      \   'grays':   {'c':  60, 'g': '#6b7089'},
      \   'red':     {'c': 174, 'g': '#e27878'},
      \   'orange':  {'c': 180, 'g': '#e2a578'},
      \   'yellow':  {'c': 214, 'g': '#fabd2f'},
      \   'green':   {'c': 144, 'g': '#b5bf82'},
      \   'cyan':    {'c': 109, 'g': '#89b9c2'},
      \   'blue':    {'c': 110, 'g': '#84a0c7'},
      \   'purple':  {'c': 140, 'g': '#a093c8'},
      \   'special': {'c':  69, 'g': '#4f86f7'}
      \ },
      \ 'onedark': {
      \   'bgh':     {'c': 235, 'g': '#24272e'},
      \   'bgm':     {'c': 236, 'g': '#282c34'},
      \   'bgs':     {'c': 238, 'g': '#3a3f4b'},
      \   'fgh':     {'c': 247, 'g': '#969faf'},
      \   'fgm':     {'c': 249, 'g': '#abb2bf'},
      \   'fgs':     {'c': 250, 'g': '#b3b9c5'},
      \   'grayh':   {'c': 240, 'g': '#525964'},
      \   'graym':   {'c': 242, 'g': '#5c6370'},
      \   'grays':   {'c': 243, 'g': '#697180'},
      \   'red':     {'c': 203, 'g': '#ef596f'},
      \   'orange':  {'c': 173, 'g': '#d19a66'},
      \   'yellow':  {'c': 180, 'g': '#e5c07b'},
      \   'green':   {'c': 114, 'g': '#89ca78'},
      \   'cyan':    {'c':  38, 'g': '#2bbac5'},
      \   'blue':    {'c':  75, 'g': '#61afef'},
      \   'purple':  {'c': 170, 'g': '#d55fde'},
      \   'special': {'c': 180, 'g': '#e2be7d'}
      \ }
      \ }

function! neutil#plt#CurrentScheme() abort
  return s:current
endfunction

" function! neutil#plt#Schemes() abort
"   return s:schemes
" endfunction

function! neutil#plt#Get(scheme = 'random') abort
  if s:schemes->has_key(a:scheme)
    let s:current = a:scheme
  elseif a:scheme == 'random'
    let s:current = 'random'
  elseif a:scheme == 'current' && !(s:schemes->has_key(s:current))
    let s:current = 'random'
  endif

  if s:current == 'random'
    let s:current = s:schemes->keys()[rand(srand()) % s:schemes->len()]
  endif

  return s:schemes[s:current]
endfunction
