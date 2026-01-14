@echo off
REM Quantum - PDF Build Script (Windows)
REM Converts Markdown papers to PDF using DocWizard-Pro

setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "DOCWIZARD_DIR=%SCRIPT_DIR%..\DocWizard-Pro\Src"
set "PAPERS_DIR=%SCRIPT_DIR%papers\zkprivacy"

echo ================================================
echo   Quantum - PDF Build Script
echo ================================================
echo.

REM Check if DocWizard-Pro exists
if not exist "%DOCWIZARD_DIR%\universal_converter.py" (
    echo ERROR: DocWizard-Pro not found at: %DOCWIZARD_DIR%
    echo        Make sure DocWizard-Pro is in the same parent directory as Quantum
    exit /b 1
)

REM Check if Pandoc is installed
where pandoc >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Pandoc is not installed
    echo        Install from: https://pandoc.org/installing.html
    exit /b 1
)

echo Building PDFs...
echo.

REM Convert specification
echo [1/2] Converting zkprivacy-quantum-spec-v1.md...
python "%DOCWIZARD_DIR%\universal_converter.py" "%PAPERS_DIR%\zkprivacy-quantum-spec-v1.md" "%PAPERS_DIR%\zkprivacy-quantum-spec-v1.pdf"

if %errorlevel% equ 0 (
    echo       Done: zkprivacy-quantum-spec-v1.pdf
) else (
    echo       FAILED: zkprivacy-quantum-spec-v1.pdf
    exit /b 1
)

REM Convert verification guide
echo [2/2] Converting zkprivacy-verification-guide.md...
python "%DOCWIZARD_DIR%\universal_converter.py" "%PAPERS_DIR%\zkprivacy-verification-guide.md" "%PAPERS_DIR%\zkprivacy-verification-guide.pdf"

if %errorlevel% equ 0 (
    echo       Done: zkprivacy-verification-guide.pdf
) else (
    echo       FAILED: zkprivacy-verification-guide.pdf
    exit /b 1
)

echo.
echo ================================================
echo   Build complete!
echo   PDFs generated in: %PAPERS_DIR%
echo ================================================

endlocal
