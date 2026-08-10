@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" neovim %*
exit /b %errorlevel%
