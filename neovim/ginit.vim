" NOTE: Please check dotfiles/font folder for available fonts.
let s:fonts = [
      \ {'name': '3270 Nerd Font Mono'           , 'size': 12},
      \ {'name': 'Agave Nerd Font Mono'          , 'size': 13},
      \ {'name': 'CaskaydiaCove NFM'             , 'size': 12},
      \ {'name': 'ComicShannsMono Nerd Font Mono', 'size': 12},
      \ {'name': 'FantasqueSansM Nerd Font Mono' , 'size': 13},
      \ {'name': 'FiraCode Nerd Font Mono Ret'   , 'size': 11},
      \ {'name': 'GohuFont uni-11 Nerd Font Mono', 'size': 12},
      \ {'name': 'GohuFont uni-14 Nerd Font Mono', 'size': 12},
      \ {'name': 'Hurmit Nerd Font Mono'         , 'size': 11},
      \ {'name': 'Input Nerd Font Mono'          , 'size': 12},
      \ {'name': 'JetBrainsMono NFM'             , 'size': 11},
      \ {'name': 'Maple Mono NF'                 , 'size': 11},
      \ {'name': 'Monocraft Nerd Font'           , 'size': 10},
      \ {'name': 'Monofur Nerd Font Mono'        , 'size': 13},
      \ {'name': 'OpenDyslexicM Nerd Font Mono'  , 'size':  9},
      \ {'name': 'ProFontWindows Nerd Font Mono' , 'size': 13},
      \ {'name': 'ProggyCleanSZ Nerd Font Mono'  , 'size': 16},
      \ {'name': 'SpaceMono Nerd Font Mono'      , 'size': 11},
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
