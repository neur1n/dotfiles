if exists('GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'input 10')
else
    exec 'GuiFont! Input\ NF:h10'
endif
