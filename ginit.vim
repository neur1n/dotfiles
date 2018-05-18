if exists('GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'mononoki NF 10')
else
    exec "GuiFont! mononoki NF:h10"
endif
