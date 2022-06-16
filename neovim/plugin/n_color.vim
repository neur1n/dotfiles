scriptencoding utf-8

if exists('g:loaded_n_color')
  finish
endif

let g:loaded_n_color = v:true

let s:save_cpo = &cpoptions
set cpoptions&vim

colorscheme neucs

let s:names = ['red', 'orange', 'yellow', 'green', 'blue', 'cyan', 'purple', 'special']

let s:id = rand(srand()) % len(s:names)
let s:plt = neutil#plt#Get('current')
let s:color = s:plt[s:names[s:id]]

call neutil#hl#Create('WinSeparator', s:color, 'bg')
call neutil#hl#Create('Pmenu'       , 'NONE', 'NONE')
call neutil#hl#Create('PmenuSel'    , 'bg', s:color, 'bold')
call neutil#hl#Create('PmenuSbar'   , 'NONE', 'fg')
call neutil#hl#Create('PmenuThumb'  , 'NONE', s:color)
call neutil#hl#Create('Question'    , s:color, 'bg')
call neutil#hl#Create('WildMenu'    , s:color, 'bg')

let &cpoptions = s:save_cpo
unlet s:save_cpo
