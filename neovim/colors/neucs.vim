scriptencoding utf-8

if v:version > 580
  if exists('syntax_on')
    syntax reset
  endif
endif

set background=dark

let s:plt = neutil#plt#Get('random')

"********************************************************** Highlight Groups{{{
call neutil#hl#Create('NeuBgH', 'NONE', s:plt.bgh)
call neutil#hl#Create('NeuBgM', 'NONE', s:plt.bgm)
call neutil#hl#Create('NeuBgS', 'NONE', s:plt.bgs)

call neutil#hl#Create('NeuFgH', s:plt.fgh)
call neutil#hl#Create('NeuFgM', s:plt.fgm)
call neutil#hl#Create('NeuFgS', s:plt.fgs)

call neutil#hl#Create('NeuGrayH', s:plt.grayh)
call neutil#hl#Create('NeuGrayM', s:plt.graym)
call neutil#hl#Create('NeuGrayS', s:plt.grays)

call neutil#hl#Create('NeuRed'   ,  s:plt.red)
call neutil#hl#Create('NeuOrange',  s:plt.orange)
call neutil#hl#Create('NeuYellow',  s:plt.yellow)
call neutil#hl#Create('NeuGreen' ,  s:plt.green)
call neutil#hl#Create('NeuCyan'  ,  s:plt.cyan)
call neutil#hl#Create('NeuBlue'  ,  s:plt.blue)
call neutil#hl#Create('NeuPurple',  s:plt.purple)
call neutil#hl#Create('NeuSpecial', s:plt.special)

call neutil#hl#Create('NeuGrayHBold', s:plt.grayh, 'NONE', 'bold')
call neutil#hl#Create('NeuGrayMBold', s:plt.graym, 'NONE', 'bold')
call neutil#hl#Create('NeuGraySBold', s:plt.grays, 'NONE', 'bold')

call neutil#hl#Create('NeuRedBold'    , s:plt.red    , 'NONE', 'bold')
call neutil#hl#Create('NeuOrangeBold' , s:plt.orange , 'NONE', 'bold')
call neutil#hl#Create('NeuYellowBold' , s:plt.yellow , 'NONE', 'bold')
call neutil#hl#Create('NeuGreenBold'  , s:plt.green  , 'NONE', 'bold')
call neutil#hl#Create('NeuCyanBold'   , s:plt.cyan   , 'NONE', 'bold')
call neutil#hl#Create('NeuBlueBold'   , s:plt.blue   , 'NONE', 'bold')
call neutil#hl#Create('NeuPurpleBold' , s:plt.purple , 'NONE', 'bold')
call neutil#hl#Create('NeuSpecialBold', s:plt.special, 'NONE', 'bold')

call neutil#hl#Create('NeuGrayHItalic', s:plt.grayh, 'NONE', 'italic')
call neutil#hl#Create('NeuGrayMItalic', s:plt.graym, 'NONE', 'italic')
call neutil#hl#Create('NeuGraySItalic', s:plt.grays, 'NONE', 'italic')

call neutil#hl#Create('NeuRedItalic'    , s:plt.red    , 'NONE', 'italic')
call neutil#hl#Create('NeuOrangeItalic' , s:plt.orange , 'NONE', 'italic')
call neutil#hl#Create('NeuYellowItalic' , s:plt.yellow , 'NONE', 'italic')
call neutil#hl#Create('NeuGreenItalic'  , s:plt.green  , 'NONE', 'italic')
call neutil#hl#Create('NeuCyanItalic'   , s:plt.cyan   , 'NONE', 'italic')
call neutil#hl#Create('NeuBlueItalic'   , s:plt.blue   , 'NONE', 'italic')
call neutil#hl#Create('NeuPurpleItalic' , s:plt.purple , 'NONE', 'italic')
call neutil#hl#Create('NeuSpecialItalic', s:plt.special, 'NONE', 'italic')
"}}}

"******************************************************************* General{{{
call neutil#hl#Create('Comment'     , s:plt.graym, 'NONE', 'italic')
call neutil#hl#Create('Normal'      , s:plt.fgm, s:plt.bgm)
" call neutil#hl#Create('NormalFloat' , s:plt.fgs, s:plt.bgs)
call neutil#hl#Create('NormalNC'    , s:plt.fgm, s:plt.bgs)

call neutil#hl#Create('ColorColumn' , 'NONE', s:plt.bgs)
call neutil#hl#Create('Cursor'      , 'NONE', 'NONE', 'inverse')
call neutil#hl#Link(  'lCursor'     , 'Cursor')
call neutil#hl#Link(  'CursorIM'    , 'Cursor')
call neutil#hl#Link(  'CursorColumn', 'ColorColumn')
call neutil#hl#Link(  'CursorLine'  , 'ColorColumn')
call neutil#hl#Link(  'Directory'   , 'NeuBlue')
call neutil#hl#Create('DiffAdd'     , 'bg', s:plt.green)
call neutil#hl#Create('DiffChange'  , 'bg', s:plt.cyan)
call neutil#hl#Create('DiffDelete'  , 'bg', s:plt.red)
call neutil#hl#Create('DiffText'    , 'bg', s:plt.yellow)
call neutil#hl#Link(  'EndOfBuffer' , 'NeuGrayM')
call neutil#hl#Link(  'TermCursor'  , 'NeuPurpleBold')
call neutil#hl#Link(  'TermCursorNC', 'NeuPurple')
call neutil#hl#Create('ErrorMsg'    , 'bg', s:plt.red, 'bold')
call neutil#hl#Link(  'Folded'      , 'Comment')
call neutil#hl#Link(  'FoldColumn'  , 'Comment')
call neutil#hl#Create('SignColumn'  , 'NONE', 'bg')
call neutil#hl#Create('IncSearch'   , s:plt.special, 'bg', 'bold,underline')
call neutil#hl#Create('Substitute'  , 'bg', s:plt.special, 'bold')
call neutil#hl#Link(  'LineNr'      , 'NeuGrayM')
call neutil#hl#Link(  'CursorLineNr', 'NeuYellow')
call neutil#hl#Create('MatchParen'  , 'NONE', s:plt.grays, 'bold')
call neutil#hl#Link(  'ModeMsg'     , 'Normal')
call neutil#hl#Link(  'MsgArea'     , 'Normal')
call neutil#hl#Link(  'MsgSeparator', 'Normal')
call neutil#hl#Link(  'MoreMsg'     , 'NeuGreen')
call neutil#hl#Link(  'NonText'     , 'Comment')
call neutil#hl#Link(  'QuickFixLine', 'CursorLine')
call neutil#hl#Link(  'Search'      , 'IncSearch')
call neutil#hl#Link(  'SpecialKey'  , 'Comment')
call neutil#hl#Create('SpellBad'    , 'NONE', 'NONE', 'undercurl', s:plt.red)
call neutil#hl#Create('SpellCap'    , 'NONE', 'NONE', 'undercurl', s:plt.orange)
call neutil#hl#Create('SpellLocal'  , 'NONE', 'NONE', 'undercurl', s:plt.green)
call neutil#hl#Create('SpellRare'   , 'NONE', 'NONE', 'undercurl', s:plt.blue)
call neutil#hl#Link(  'StatusLine'  , 'Normal')
call neutil#hl#Link(  'StatusLineNC', 'NormalNC')
call neutil#hl#Link(  'TabLine'     , 'Normal')
call neutil#hl#Link(  'TabLineFill' , 'Normal')
call neutil#hl#Link(  'TabLineSel'  , 'NeuPurple')
call neutil#hl#Link(  'Title'       , 'NeuGreen')
call neutil#hl#Create('Visual'      , 'NONE', s:plt.grays)
call neutil#hl#Link(  'VisualNOS'   , 'Visual')
call neutil#hl#Create('WarningMsg'  , 'bg', s:plt.yellow, 'bold')

" NOTE: the followings are not set
"   Conceal
"   WinSeparator
"   LineNrAbove
"   LineNrBelow
"   CursorLineSign
"   CursorLineFold
"   Pmenu
"   PmenuSel
"   PmenuSbar
"   PmenuThumb
"   Question
"   WildMenu
"}}}

"************************************************************ Generic Syntax{{{
call neutil#hl#Link('Boolean'     , 'NeuPurple')
call neutil#hl#Link('Character'   , 'NeuPurple')
call neutil#hl#Link('Conditional' , 'NeuRedItalic')
call neutil#hl#Link('Constant'    , 'NeuPurple')
call neutil#hl#Link('Define'      , 'NeuCyan')
call neutil#hl#Link('Exception'   , 'NeuRed')
call neutil#hl#Link('Float'       , 'NeuPurple')
call neutil#hl#Link('Function'    , 'NeuGreenBold')
call neutil#hl#Link('Include'     , 'NeuCyan')
call neutil#hl#Link('Identifier'  , 'NeuBlue')
call neutil#hl#Link('Keyword'     , 'NeuRed')
call neutil#hl#Link('Label'       , 'NeuRed')
call neutil#hl#Link('Macro'       , 'NeuCyan')
call neutil#hl#Link('Number'      , 'NeuPurple')
call neutil#hl#Link('Operator'    , 'Normal')
call neutil#hl#Link('PreCondit'   , 'NeuCyan')
call neutil#hl#Link('PreProc'     , 'NeuCyan')
call neutil#hl#Link('Repeat'      , 'NeuRedItalic')
call neutil#hl#Link('Statement'   , 'NeuRed')
call neutil#hl#Link('StorageClass', 'NeuOrange')
call neutil#hl#Link('String'      , 'NeuGreen')
call neutil#hl#Link('Structure'   , 'NeuCyan')
call neutil#hl#Link('Type'        , 'NeuYellow')
call neutil#hl#Link('Typedef'     , 'NeuYellow')

call neutil#hl#Link(  'Special'  , 'NeuOrange')
call neutil#hl#Create('Bold'     , 'NONE', 'NONE', 'bold')
call neutil#hl#Create('Italic'   , 'NONE', 'NONE', 'italic')
call neutil#hl#Create('Underline', 'NONE', 'NONE', 'underline')

call neutil#hl#Link('Debug', 'NeuBlue')
call neutil#hl#Link('Error', 'NeuRed')
call neutil#hl#Link('Note' , 'NeuSpecial')
call neutil#hl#Link('Tag'  , 'NeuGreen')
call neutil#hl#Link('Todo' , 'NeuOrange')
"}}}

"****************************************************************** Terminal{{{
if has('nvim')
  let g:terminal_color_0 = s:plt.bgm.g
  let g:terminal_color_8 = s:plt.graym.g

  let g:terminal_color_1 = s:plt.red.g
  let g:terminal_color_9 = s:plt.red.g

  let g:terminal_color_2 = s:plt.green.g
  let g:terminal_color_10 = s:plt.green.g

  let g:terminal_color_3 = s:plt.yellow.g
  let g:terminal_color_11 = s:plt.yellow.g

  let g:terminal_color_4 = s:plt.blue.g
  let g:terminal_color_12 = s:plt.blue.g

  let g:terminal_color_5 = s:plt.purple.g
  let g:terminal_color_13 = s:plt.purple.g

  let g:terminal_color_6 = s:plt.cyan.g
  let g:terminal_color_14 = s:plt.cyan.g

  let g:terminal_color_7 = s:plt.fgs.g
  let g:terminal_color_15 = s:plt.fgm.g
endif
"}}}

let g:colors_name = 'neucs'
