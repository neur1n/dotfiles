@echo off

MKLINK %USERPROFILE%\Documents\Powershell\Microsoft.PowerShell_profile.ps1 %CD%\..\..\pwsh\Microsoft.PowerShell_profile.ps1
MKLINK %USERPROFILE%\Documents\Powershell\z.lua %CD%\..\..\pwsh\z.lua
