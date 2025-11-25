@echo off

SET src=%~dp0.\..\..\komorebi
SET dst=%USERPROFILE%

MKLINK %dst%\komorebi.json %src%\komorebi.json
MKLINK %dst%\komorebi.app.json %src%\komorebi.app.json
MKLINK %dst%\komorebi.bar.json %src%\komorebi.bar.json
MKLINK %dst%\.config\whkdrc %src%\whkdrc

START %dst%
