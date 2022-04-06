@echo off

MKLINK /J %APPDATA%\.emacs.d\configs %CD%\..\..\.emacs.d\configs
MKLINK /J %APPDATA%\.emacs.d\elpa %CD%\..\..\.emacs.d\elpa
MKLINK /J %APPDATA%\.emacs.d\plugins %CD%\..\..\.emacs.d\plugins

MKLINK %APPDATA%\.emacs.d\init.el %CD%\..\..\.emacs.d\init.el
