@echo off

SET src=%~dp0.
SET dst=%APPDATA%\nushell

MKLINK /J %dst%\module %src%\..\..\nu\module
MKLINK /J %dst%\script %src%\..\..\nu\script

MKLINK %dst%\config.nu %src%\..\..\nu\config.nu
MKLINK %dst%\env.nu %src%\..\..\nu\env.nu

START %dst%
