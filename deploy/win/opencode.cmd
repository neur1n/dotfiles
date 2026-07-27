@echo off

SET src=%~dp0.\..\..\opencode
SET dst=%USERPROFILE%\.config\opencode

MKLINK /J %dst% %src%

START %dst%
