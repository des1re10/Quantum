@echo off
setlocal enabledelayedexpansion

REM ============================================================================
REM Quantum - Deployment to pCloud (Windows)
REM ============================================================================
REM Copies website files from development machine to pCloud for server sync
REM
REM Usage: deploy_testing.bat [full]
REM   - full: Deploy ALL files (for fresh server installation)
REM   - (no argument): Same behavior (static site always deploys all files)
REM ============================================================================

REM === Parse command line arguments ===
set "FULL_DEPLOY=0"
if /I "%~1"=="full" set "FULL_DEPLOY=1"

echo ================================================
echo   Quantum - Deploy to pCloud
echo ================================================
if "%FULL_DEPLOY%"=="1" (
    echo   Mode: FULL DEPLOYMENT
) else (
    echo   Mode: Standard deployment
)
echo.

REM === Configuration ===
set "PROJECT_NAME=Quantum"
set "SOURCE_DIR=%~dp0..\.."
set "TARGET_DIR=P:\Crypto Folder\Quantum Sources\Quantum"

echo Source: %SOURCE_DIR%
echo Target: %TARGET_DIR%
echo.

REM === Check pCloud is mounted ===
if not exist "P:\" (
    echo ERROR: pCloud drive not found!
    echo Please ensure pCloud is running and P: drive is mapped
    if not defined AUTO_DEPLOY pause
    exit /b 1
)

REM === Create target directory if needed ===
if not exist "%TARGET_DIR%" (
    echo Creating target directory...
    mkdir "%TARGET_DIR%"
)

REM === Copy files ===
echo.
echo Copying files to pCloud...
echo.

REM Copy main files
echo [1/7] Copying index.html...
copy /Y "%SOURCE_DIR%\index.html" "%TARGET_DIR%\"

echo [2/7] Copying assets...
if not exist "%TARGET_DIR%\assets\css" mkdir "%TARGET_DIR%\assets\css"
if not exist "%TARGET_DIR%\assets\images" mkdir "%TARGET_DIR%\assets\images"
xcopy /E /I /Y "%SOURCE_DIR%\assets" "%TARGET_DIR%\assets"

echo [3/7] Copying papers...
if not exist "%TARGET_DIR%\papers\zkprivacy" mkdir "%TARGET_DIR%\papers\zkprivacy"
xcopy /E /I /Y "%SOURCE_DIR%\papers" "%TARGET_DIR%\papers"

echo [4/7] Copying documentation...
copy /Y "%SOURCE_DIR%\README.md" "%TARGET_DIR%\" 2>nul
copy /Y "%SOURCE_DIR%\CLAUDE.md" "%TARGET_DIR%\" 2>nul
if not exist "%TARGET_DIR%\Documentation" mkdir "%TARGET_DIR%\Documentation"
xcopy /E /I /Y "%SOURCE_DIR%\Documentation" "%TARGET_DIR%\Documentation"

echo [5/7] Copying build scripts...
copy /Y "%SOURCE_DIR%\build-pdfs.bat" "%TARGET_DIR%\" 2>nul
copy /Y "%SOURCE_DIR%\build-pdfs.sh" "%TARGET_DIR%\" 2>nul
copy /Y "%SOURCE_DIR%\start-local.bat" "%TARGET_DIR%\" 2>nul
copy /Y "%SOURCE_DIR%\start-local.sh" "%TARGET_DIR%\" 2>nul

echo [6/7] Copying deployment scripts...
if not exist "%TARGET_DIR%\tools\Scripts\Startup" mkdir "%TARGET_DIR%\tools\Scripts\Startup"
xcopy /E /I /Y "%SOURCE_DIR%\tools\Scripts" "%TARGET_DIR%\tools\Scripts"

echo [7/7] Copying .gitignore...
copy /Y "%SOURCE_DIR%\.gitignore" "%TARGET_DIR%\" 2>nul

REM === Summary ===
echo.
echo ================================================
echo   Deployment to pCloud COMPLETE
echo ================================================
echo.
echo Files synced to: %TARGET_DIR%
echo.
echo NEXT STEPS:
echo 1. Wait for pCloud sync to complete
echo 2. SSH to production server
echo 3. Run: ~/Quantum/Quantum/tools/Scripts/Startup/quantum_deploy_script.sh
echo.

if not defined AUTO_DEPLOY pause
endlocal
exit /b 0
