@echo off

SET src=%~dp0.
SET dst=%USERPROFILE%

MKLINK /J %dst%\.wezterm %src%\..\..\wezterm\.wezterm
MKLINK %dst%\.wezterm.lua %src%\..\..\wezterm\.wezterm.lua

START %dst%
