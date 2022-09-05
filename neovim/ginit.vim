" NOTE: Please check dotfiles/font folder for available fonts.
let s:fonts = [
      \ {'name': 'Anonymice NF'         , 'size': 13},
      \ {'name': 'CaskaydiaCove NF Mono', 'size': 12},
      \ {'name': 'DaddyTimeMono NF'     , 'size': 12},
      \ {'name': 'FantasqueSansMono NF' , 'size': 13},
      \ {'name': 'FiraCode NF'          , 'size': 11},
      \ {'name': 'GohuFont NF'          , 'size': 12},
      \ {'name': 'Hurmit NF'            , 'size': 11},
      \ {'name': 'Input NF'             , 'size': 12},
      \ {'name': 'JetBrainsMono NF'     , 'size': 11},
      \ {'name': 'Monofur NF'           , 'size': 13},
      \ {'name': 'ProFontWindows NF'    , 'size': 14},
      \ {'name': 'ProggyCleanTT NF'     , 'size': 16},
      \ {'name': 'SauceCodePro NF'      , 'size': 11},
      \ {'name': 'SpaceMono NF'         , 'size': 11},
      \ {'name': 'VictorMono NF'        , 'size': 12},
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
