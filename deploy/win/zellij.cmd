@echo off

SET src=%~dp0.\..\..\zellij
SET dst=%USERPROFILE%\.config\zellij

MKLINK /J %dst% %src%

START %dst%
