@echo off

SET src=%~dp0.
SET dst=%USERPROFILE%

IF EXIST %dst%\komorebi.json (
  DEL /Q %dst%\komorebi.json
)

IF EXIST %dst%\komorebi.app.json (
  DEL /Q %dst%\komorebi.app.json
)

IF EXIST %dst%\komorebi.bar.json (
  DEL /Q %dst%\komorebi.bar.json
)

IF NOT EXIST %dst%\.config (
  MKDIR %dst%\.config
)

IF EXIST %dst%\.config\whkdrc (
  DEL /Q %dst%\.config\whkdrc
)

MKLINK %dst%\komorebi.json %src%\..\..\komorebi\komorebi.json
MKLINK %dst%\komorebi.app.json %src%\..\..\komorebi\komorebi.app.json
MKLINK %dst%\komorebi.bar.json %src%\..\..\komorebi\komorebi.bar.json
MKLINK %dst%\.config\whkdrc %src%\..\..\komorebi\whkdrc

START %dst%
