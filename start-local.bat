@echo off
REM Quantum - Local Development Server (Windows)
REM Quick start script for testing the website locally

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "PAPERS_DIR=%SCRIPT_DIR%papers\zkprivacy"

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
echo URL: http://localhost:8080
echo Press Ctrl+C to stop
echo.

python -m http.server 8080

endlocal
