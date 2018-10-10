if exists('GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'input 10')
else
    exec 'GuiFont! input\ NF:h10'
endif
