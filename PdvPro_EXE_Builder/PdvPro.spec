# -*- mode: python ; coding: utf-8 -*-
#
# Spec do PyInstaller para o PDV Pro (Delicias Food).
# Gera um unico arquivo dist\PdvPro.exe, sem janela de console.
#
# Como usar (no Windows, dentro desta pasta, com o PdvPro.py ao lado):
#     python -m PyInstaller --clean PdvPro.spec
#
from PyInstaller.utils.hooks import collect_submodules, copy_metadata

# --- Hidden imports (modulos que o PyInstaller nao detecta sozinho) ---
hiddenimports = [
    'tkinter', 'tkinter.ttk', 'tkinter.scrolledtext', 'tkinter.filedialog',
    'tkinter.messagebox', 'tkinter.simpledialog',
    'PIL', 'PIL.Image', 'PIL.ImageTk',
    # mysql.connector precisa destes modulos "escondidos" para conectar:
    'mysql.connector',
    'mysql.connector.plugins',
    'mysql.connector.plugins.mysql_native_password',
    'mysql.connector.plugins.caching_sha2_password',
    'mysql.connector.locales',
    'mysql.connector.locales.eng',
    'mysql.connector.locales.eng.client_error',
]
# Pega TODOS os submodulos do mysql.connector (resolve a maioria dos erros)
hiddenimports += collect_submodules('mysql.connector')

# --- Metadados (resolve o erro "pkg_resources / PackageNotFoundError") ---
datas = []
for _pkg in ('mysql-connector-python', 'Pillow'):
    try:
        datas += copy_metadata(_pkg)
    except Exception:
        pass

a = Analysis(
    ['PdvPro.py'],
    pathex=[],
    binaries=[],
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='PdvPro',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,            # False = sem janela preta de console
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    # Para usar um icone proprio, descomente e aponte para um .ico:
    # icon='pdvpro.ico',
)
