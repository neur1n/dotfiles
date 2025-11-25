@echo off

SET src=%~dp0.\..\..\wezterm
SET dst=%USERPROFILE%

MKLINK /J %dst%\.wezterm %src%\.wezterm
MKLINK %dst%\.wezterm.lua %src%\.wezterm.lua

START %dst%
