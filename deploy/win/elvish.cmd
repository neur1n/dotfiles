@echo off

SET src=%~dp0.
SET dst=%APPDATA%\elvish

IF NOT EXIST %dst%\NUL (
  MKDIR %dst%
)

MKLINK /J %dst%\lib %src%\..\..\elvish\lib

MKLINK %dst%\rc.elv %src%\..\..\elvish\rc.elv

START %dst%
