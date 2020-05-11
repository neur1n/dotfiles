" Font candidates:
"   CaskaydiaCove NF
"   FantasqueSansMono NF

if has('win32')
  let s:cmd = 'wmic path Win32_VideoController get CurrentHorizontalResolution'
elseif has('unix')
  let s:cmd = 'xdpyinfo | grep dimensions'
endif

if matchstr(system(s:cmd), '[0-9]\+') == 2560
  execute 'GuiFont! CaskaydiaCove\ NF:h12'
else
  execute 'GuiFont! CaskaydiaCove\ NF:h10'
endif

execute 'GuiTabline 0'
execute 'GuiPopupmenu 0'
