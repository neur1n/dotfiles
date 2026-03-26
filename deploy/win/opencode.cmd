@echo off

SET src=%~dp0.\..\..\opencode
SET dst=%USERPROFILE%\.config\opencode

MKLINK %dst%\tui.json %src%\tui.json

START %dst%
