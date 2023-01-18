" NOTE: Please check dotfiles/font folder for available fonts.
let s:fonts = [
      \ {'name': '3270SemiCondensed NFM'   , 'size': 14},
      \ {'name': 'agave NFM'               , 'size': 13},
      \ {'name': 'BigBlue_TerminalPlus NFM', 'size': 10},
      \ {'name': 'CaskaydiaCove NF Mono'   , 'size': 12},
      \ {'name': 'DaddyTimeMono NFM'       , 'size': 12},
      \ {'name': 'FantasqueSansMono NFM'   , 'size': 13},
      \ {'name': 'FiraCode NFM'            , 'size': 11},
      \ {'name': 'GohuFont NFM'            , 'size': 12},
      \ {'name': 'Hurmit NFM'              , 'size': 11},
      \ {'name': 'Input NF'                , 'size': 12},
      \ {'name': 'JetBrainsMono NFM'       , 'size': 11},
      \ {'name': 'Monofur NFM'             , 'size': 13},
      \ {'name': 'ProFontWindows NFM'      , 'size': 13},
      \ {'name': 'ProggyCleanTT NFM'       , 'size': 16},
      \ {'name': 'SpaceMono NFM'           , 'size': 11},
      \ ]
let s:index = rand(srand()) % len(s:fonts)

if has('win32')
  let s:cmd = 'wmic path Win32_VideoController get CurrentHorizontalResolution'
elseif has('unix')
  let s:cmd = 'xdpyinfo | grep dimensions'
endif

if matchstr(system(s:cmd), '[0-9]\+') == 2560
  execute printf('GuiFont! %s:h%d', s:fonts[s:index]['name'], s:fonts[s:index]['size'])
else
  execute printf('GuiFont! %s:h%d', s:fonts[s:index]['name'], s:fonts[s:index]['size'] - 2)
endif

execute 'GuiTabline 0'
execute 'GuiPopupmenu 0'
