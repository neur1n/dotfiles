@echo off

SET src=%~dp0.
SET dst=%LOCALAPPDATA%\nvim

IF EXIST %dst% (
  RMDIR /S /Q %dst%
)

MKLINK /J %dst% %src%\..\..\neovim

START %dst%
