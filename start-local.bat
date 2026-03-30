@echo off
REM Quantum - Local Development Server (Windows)
REM Quick start script for testing the website locally

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "PAPERS_DIR=%SCRIPT_DIR%papers\zkprivacy"
set "LIBRARIES_PYTHON=%SCRIPT_DIR%..\Libraries\Python"
set "DEFAULT_PORT=9180"
set "PORT=%~1"

if "%PORT%"=="" (
    for /f "usebackq delims=" %%i in (`python -c "import sys; sys.path.insert(0, r'%LIBRARIES_PYTHON%'); from ApplicationRegistry import get_application; config = get_application('quantum'); print(getattr(config, 'local_preview_port', '') or '')" 2^>nul`) do set "PORT=%%i"
)
if "%PORT%"=="" set "PORT=%DEFAULT_PORT%"

pushd "%SCRIPT_DIR%"

echo ================================================
echo   Quantum - Post-Quantum Cryptography Research
echo   Local Development Server
echo ================================================
echo.

REM Check if PDFs need to be built
set "REBUILD_NEEDED=0"

REM Check spec PDF
if not exist "%PAPERS_DIR%\zkprivacy-quantum-spec-v1.pdf" (
    set "REBUILD_NEEDED=1"
) else (
    REM Check if MD is newer than PDF
    for %%A in ("%PAPERS_DIR%\zkprivacy-quantum-spec-v1.md") do set "MD_TIME=%%~tA"
    for %%A in ("%PAPERS_DIR%\zkprivacy-quantum-spec-v1.pdf") do set "PDF_TIME=%%~tA"
    if "!MD_TIME!" gtr "!PDF_TIME!" set "REBUILD_NEEDED=1"
)

REM Check guide PDF
if not exist "%PAPERS_DIR%\zkprivacy-verification-guide.pdf" (
    set "REBUILD_NEEDED=1"
) else (
    for %%A in ("%PAPERS_DIR%\zkprivacy-verification-guide.md") do set "MD_TIME=%%~tA"
    for %%A in ("%PAPERS_DIR%\zkprivacy-verification-guide.pdf") do set "PDF_TIME=%%~tA"
    if "!MD_TIME!" gtr "!PDF_TIME!" set "REBUILD_NEEDED=1"
)

REM Auto-generate PDFs if needed
if "%REBUILD_NEEDED%"=="1" (
    echo PDFs missing or outdated. Building automatically...
    echo.

    if exist "%SCRIPT_DIR%build-pdfs.bat" (
        call "%SCRIPT_DIR%build-pdfs.bat"

        if errorlevel 1 (
            echo.
            echo WARNING: PDF generation failed!
            set /p "continue=Continue without PDFs? (y/n): "
            if /i not "!continue!"=="y" exit /b 1
        )
        echo.
    ) else (
        echo WARNING: build-pdfs.bat not found!
        set /p "continue=Continue without PDFs? (y/n): "
        if /i not "!continue!"=="y" exit /b 1
    )
) else (
    echo PDFs are up to date.
    echo.
)

REM Start Python HTTP server
echo Starting local web server...
echo URL: http://localhost:%PORT%
echo Press Ctrl+C to stop
echo.

python -m http.server %PORT%
set "SERVER_EXIT_CODE=!ERRORLEVEL!"

popd
endlocal
exit /b %SERVER_EXIT_CODE%
