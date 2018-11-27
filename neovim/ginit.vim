if has('unix')
    exec 'GuiFont! Input\ NF:h8'
elseif has('win32')
    exec 'GuiFont! Input\ NF:h10'
endif
