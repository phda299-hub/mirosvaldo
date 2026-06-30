@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ============================================================
echo  GERANDO PdvPro.exe usando o arquivo PdvPro.spec
echo ============================================================
echo.

if not exist "PdvPro.py" (
    echo ERRO: O arquivo PdvPro.py NAO esta nesta pasta.
    pause
    exit /b 1
)

if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

python -m PyInstaller --clean PdvPro.spec

if errorlevel 1 (
    echo ERRO ao gerar pelo .spec.
    pause
    exit /b 1
)

echo.
echo EXE em: dist\PdvPro.exe
pause
endlocal
