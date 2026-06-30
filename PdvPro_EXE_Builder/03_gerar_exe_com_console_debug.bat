@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ============================================================
echo  GERANDO PdvPro.exe (COM console - modo DEBUG)
echo  Use esta versao para VER os erros se a outra falhar.
echo ============================================================
echo.

if not exist "PdvPro.py" (
    echo ERRO: O arquivo PdvPro.py NAO esta nesta pasta.
    pause
    exit /b 1
)

if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

python -m PyInstaller ^
 --onefile ^
 --console ^
 --clean ^
 --name "PdvPro_debug" ^
 --collect-submodules mysql.connector ^
 --copy-metadata mysql-connector-python ^
 --hidden-import mysql.connector.locales.eng.client_error ^
 --hidden-import mysql.connector.plugins.mysql_native_password ^
 --hidden-import mysql.connector.plugins.caching_sha2_password ^
 --hidden-import PIL.ImageTk ^
 "PdvPro.py"

echo.
echo Se gerou, rode dist\PdvPro_debug.exe pelo PROMPT para ver as mensagens.
pause
endlocal
