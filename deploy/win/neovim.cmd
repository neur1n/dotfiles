@echo off

FOR /F %%d IN ('DIR /B /A:D %CD%\..\..\neovim\*') DO (
  MKLINK /J %LOCALAPPDATA%\nvim\%%d %CD%\..\..\neovim\%%d
)

FOR /F %%f IN ('DIR /B /A-D %CD%\..\..\neovim\*') DO (
  MKLINK %LOCALAPPDATA%\nvim\%%f %CD%\..\..\neovim\%%f
)

MKDIR %LOCALAPPDATA%\nvim\recovery\backup
MKDIR %LOCALAPPDATA%\nvim\recovery\session

START %LOCALAPPDATA%\nvim
