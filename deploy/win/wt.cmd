@echo off

SET src=%~dp0.
SET dst=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState

MKLINK %dst%\settings.json %src%\..\..\wt\settings.json

START %dst%
