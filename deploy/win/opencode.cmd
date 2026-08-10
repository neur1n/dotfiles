@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" opencode %*
exit /b %errorlevel%
