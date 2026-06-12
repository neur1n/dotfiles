@echo off

SET src=%~dp0.\..\..\opencode
SET dst=%USERPROFILE%\.config\opencode

MKLINK /J %dst%\opencode-quota %src%\opencode-quota
MKLINK %dst%\AGENTS.md %src%\AGENTS.md
MKLINK %dst%\opencode.json %src%\opencode.json
MKLINK %dst%\tui.json %src%\tui.json

START %dst%
