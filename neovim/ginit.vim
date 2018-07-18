if exists('GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'input 10')
else
    exec 'GuiFont! input:h10'
    " exec 'GuiFont! Monofur\ Nerd\ Font\ Mono:h10'
    " exec 'GuiFont! 3270SemiNarrow\ NF:h10'
endif
