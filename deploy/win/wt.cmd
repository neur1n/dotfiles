@echo off

SET src=%~dp0.\..\..\wt
SET dst=%USERPROFILE%\.wt

MKLINK /J %dst% %src%

START %dst%
