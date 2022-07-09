@echo off

SET src=%~dp0.
SET dst=%LOCALAPPDATA%\nvim

FOR /F %%d IN ('DIR /B /A:D %src%\..\..\neovim\*') DO (
  MKLINK /J %dst%\%%d %src%\..\..\neovim\%%d
)

FOR /F %%f IN ('DIR /B /A-D %src%\..\..\neovim\*') DO (
  MKLINK %dst%\%%f %src%\..\..\neovim\%%f
)

MKDIR %dst%\recovery\backup
MKDIR %dst%\recovery\session

START %dst%
