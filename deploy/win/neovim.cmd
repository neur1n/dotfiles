@echo off

SET src=%~dp0.\..\..\neovim
SET dst=%LOCALAPPDATA%\nvim

MKLINK /J %dst% %src%

START %dst%
