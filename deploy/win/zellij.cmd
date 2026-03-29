@echo off

SET src=%~dp0.\..\..\zellij
SET dst=%APPDATA%\Zellij\config

SET parent=%APPDATA%\Zellij
IF NOT EXIST "%parent%" (
  MKDIR %parent%
)

MKLINK /J %dst% %src%

START %dst%
