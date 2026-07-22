@echo off
setlocal enabledelayedexpansion

REM Thin wrapper - all deployment, verification, manifest, and Git logic is shared.
set "PROJECT_NAME=Quantum"
set "TARGET_DIR=P:\Crypto Folder\Quantum Sources\Quantum"
set "DELETE_REMOVED_FILES=1"

cd /d "%~dp0..\.."
call "%~dp0..\..\..\Libraries\deploy_common.bat" "%PROJECT_NAME%" "%TARGET_DIR%" "%~1" "auto" "%DELETE_REMOVED_FILES%"
set "DEPLOY_EXIT_CODE=!ERRORLEVEL!"
endlocal & exit /b %DEPLOY_EXIT_CODE%
