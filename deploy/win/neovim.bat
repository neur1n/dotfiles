@echo off

MKLINK /J %LOCALAPPDATA%\nvim\after %CD%\..\..\neovim\after
MKLINK /J %LOCALAPPDATA%\nvim\autoload %CD%\..\..\neovim\autoload
MKLINK /J %LOCALAPPDATA%\nvim\colors %CD%\..\..\neovim\colors
MKLINK /J %LOCALAPPDATA%\nvim\configs %CD%\..\..\neovim\configs
MKLINK /J %LOCALAPPDATA%\nvim\indent %CD%\..\..\neovim\indent
MKLINK /J %LOCALAPPDATA%\nvim\lua %CD%\..\..\neovim\lua
MKLINK /J %LOCALAPPDATA%\nvim\plugged %CD%\..\..\neovim\plugged
MKLINK /J %LOCALAPPDATA%\nvim\spell %CD%\..\..\neovim\spell
MKLINK /J %LOCALAPPDATA%\nvim\syntax %CD%\..\..\neovim\syntax
MKLINK /J %LOCALAPPDATA%\nvim\templates %CD%\..\..\neovim\templates

MKLINK %LOCALAPPDATA%\nvim\coc-settings.json %CD%\..\..\neovim\coc-settings.json
MKLINK %LOCALAPPDATA%\nvim\ginit.vim %CD%\..\..\neovim\ginit.vim
MKLINK %LOCALAPPDATA%\nvim\init.vim %CD%\..\..\neovim\init.vim

MKDIR %LOCALAPPDATA%\nvim\recovery\backup
MKDIR %LOCALAPPDATA%\nvim\recovery\session
