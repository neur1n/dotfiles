@echo off

SET src=%~dp0.\..\..\nushell
SET dst=%APPDATA%\nushell

MKLINK /J %dst% %src%

START %dst%
