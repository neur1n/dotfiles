@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" komorebi %*
exit /b %errorlevel%
