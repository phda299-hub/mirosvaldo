@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ============================================================
echo  PDV Pro - Instalando dependencias para gerar o EXE
echo ============================================================
echo.

python --version
if errorlevel 1 (
    echo.
    echo ERRO: Python nao encontrado no PATH.
    echo Instale o Python 3.11 ou 3.12 ^(64-bit^) marcando
    echo "Add Python to PATH" durante a instalacao.
    echo Download: https://www.python.org/downloads/windows/
    pause
    exit /b 1
)

echo.
echo Atualizando o pip...
python -m pip install --upgrade pip

echo.
echo Instalando PyInstaller, mysql-connector-python, Pillow e pywin32...
python -m pip install -r requirements.txt

echo.
echo ============================================================
echo  Dependencias instaladas. Agora rode: 02_gerar_exe_sem_console.bat
echo ============================================================
pause
endlocal
