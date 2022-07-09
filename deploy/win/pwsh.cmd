@echo off

SET src=%~dp0.
SET dst=%USERPROFILE%\Documents\Powershell

MKLINK %dst%\Microsoft.PowerShell_profile.ps2 %src%\..\..\pwsh\Microsoft.PowerShell_profile.ps1
MKLINK %dst%\z.lua %src%\..\..\pwsh\z.lua

START %dst%
