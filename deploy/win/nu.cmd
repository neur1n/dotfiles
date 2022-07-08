@echo off

MKLINK /J %APPDATA%\nushell\module %CD%\..\..\nu\module
MKLINK /J %APPDATA%\nushell\script %CD%\..\..\nu\script

MKLINK %APPDATA%\nushell\config.nu %CD%\..\..\nu\config.nu
MKLINK %APPDATA%\nushell\env.nu %CD%\..\..\nu\env.nu
