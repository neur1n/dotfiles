@echo off

SET src=%~dp0.\..\..\opencode
SET dst=%USERPROFILE%\.config\opencode

MKLINK %dst%\opencode.json %src%\opencode.json

START %dst%
