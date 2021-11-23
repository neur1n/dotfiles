" NOTE: Please check dotfiles/font folder for available fonts.
let s:fonts = [
      \ {'name': 'Anonymice',         'size': 13},
      \ {'name': 'CaskaydiaCove',     'size': 12},
      \ {'name': 'FantasqueSansMono', 'size': 13},
      \ {'name': 'FiraCode',          'size': 11},
      \ {'name': 'GohuFont',          'size': 12},
      \ {'name': 'Input',             'size': 10.5},
      \ {'name': 'ProggyCleanTT',     'size': 16},
      \ {'name': 'SpaceMono',         'size': 11},
      \ ]
let s:index = strftime('%M') % len(s:fonts)

" if has('win32')
"   let s:cmd = 'wmic path Win32_VideoController get CurrentHorizontalResolution'
" elseif has('unix')
"   let s:cmd = 'xdpyinfo | grep dimensions'
" endif

execute printf('GuiFont! %s\ NF:h%d', s:fonts[s:index]['name'], s:fonts[s:index]['size'])
" if matchstr(system(s:cmd), '[0-9]\+') == 2560
"   execute printf('GuiFont! %s\ NF:h%d', s:fonts[s:index]['name'], s:fonts[s:index]['size'])
" else
"   execute 'GuiFont! ProFontWindows\ NF:h10'
" endif

execute 'GuiTabline 0'
execute 'GuiPopupmenu 0'
