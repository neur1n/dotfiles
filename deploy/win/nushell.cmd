@echo off

SET src=%~dp0.
SET dst=%APPDATA%\nushell

MKLINK /J %dst%\module %src%\..\..\nushell\module
MKLINK /J %dst%\script %src%\..\..\nushell\script

MKLINK %dst%\config.nu %src%\..\..\nushell\config.nu
MKLINK %dst%\env.nu %src%\..\..\nushell\env.nu

START %dst%
