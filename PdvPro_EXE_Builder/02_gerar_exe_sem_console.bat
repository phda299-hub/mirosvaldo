@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ============================================================
echo  GERANDO PdvPro.exe (sem console)
echo ============================================================
echo.

if not exist "PdvPro.py" (
    echo ERRO: O arquivo PdvPro.py NAO esta nesta pasta.
    echo Copie o PdvPro.py para a mesma pasta deste .bat e tente de novo.
    pause
    exit /b 1
)

python --version
if errorlevel 1 (
    echo ERRO: Python nao encontrado no PATH. Rode 01_instalar_dependencias.bat primeiro.
    pause
    exit /b 1
)

echo Limpando builds antigos...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

echo.
echo Compilando em um unico arquivo .exe...
python -m PyInstaller ^
 --onefile ^
 --noconsole ^
 --clean ^
 --name "PdvPro" ^
 --collect-submodules mysql.connector ^
 --copy-metadata mysql-connector-python ^
 --hidden-import mysql.connector.locales.eng.client_error ^
 --hidden-import mysql.connector.plugins.mysql_native_password ^
 --hidden-import mysql.connector.plugins.caching_sha2_password ^
 --hidden-import PIL.ImageTk ^
 --hidden-import tkinter ^
 --hidden-import tkinter.ttk ^
 --hidden-import tkinter.scrolledtext ^
 --hidden-import tkinter.filedialog ^
 --hidden-import tkinter.messagebox ^
 --hidden-import tkinter.simpledialog ^
 "PdvPro.py"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao gerar o EXE.
    echo Rode 03_gerar_exe_com_console_debug.bat para ver a mensagem de erro completa.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  EXE GERADO COM SUCESSO:  dist\PdvPro.exe
echo ============================================================
echo Caminho completo: %CD%\dist\PdvPro.exe
echo.
pause
endlocal
