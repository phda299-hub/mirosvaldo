@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Limpando pastas build e dist...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo Pronto.
pause
