@echo off

SET src=%~dp0.
SET dst=%USERPROFILE%

MKLINK %dst%\.wezterm.lua %src%\..\..\wezterm\.wezterm.lua

START %dst%
