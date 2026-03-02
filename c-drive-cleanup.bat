@echo off
REM setlocal EnableDelayedExpansion

REM echo ========================================
REM echo   Windows Dev Machine Cleanup Utility
REM echo   Stable v6
REM echo ========================================
REM echo.

=========================================
CHECK ADMIN RIGHTS
=========================================

REM set IS_ADMIN=0
REM net session >nul 2>&1
REM if !errorlevel!==0 (
    REM set IS_ADMIN=1
REM )

REM if "!IS_ADMIN!"=="1" (
    REM echo Running with Administrator privileges.
REM ) else (
    REM echo WARNING: Not running as Administrator.
    REM echo System-level cleanup will be skipped.
REM )
REM echo.

=========================================
CHECK RUNNING APPS (HARD STOP)
=========================================

REM tasklist | findstr /i "chrome.exe" >nul
REM if !errorlevel!==0 (
    REM echo ERROR: Chrome is running. Close it and re-run the script.
    REM pause
    REM exit /b 1
REM )

REM tasklist | findstr /i "msedge.exe" >nul
REM if !errorlevel!==0 (
    REM echo ERROR: Edge is running. Close it and re-run the script.
    REM pause
    REM exit /b 1
REM )

REM tasklist | findstr /i "Code.exe" >nul
REM if !errorlevel!==0 (
    REM echo ERROR: VS Code is running. Close it and re-run the script.
    REM pause
    REM exit /b 1
REM )

REM set "USER_HOME=%USERPROFILE%"

REM echo Running cleanup for: %USERNAME%
REM echo.

=========================================
CHROME CACHE
=========================================

REM echo Cleaning Chrome cache...
REM set "CHROME=%USER_HOME%\AppData\Local\Google\Chrome\User Data"

REM for /d %%p in ("%CHROME%\Profile*") do (
    REM call :CleanFolder "%%p\Cache"
    REM call :CleanFolder "%%p\Code Cache"
    REM call :CleanFolder "%%p\GPUCache"
    REM call :CleanFolder "%%p\Service Worker\CacheStorage"
REM )

REM call :CleanFolder "%CHROME%\Default\Cache"
REM call :CleanFolder "%CHROME%\Default\Code Cache"
REM call :CleanFolder "%CHROME%\Default\GPUCache"
REM call :CleanFolder "%CHROME%\Default\Service Worker\CacheStorage"

=========================================
EDGE CACHE
=========================================

REM echo.
REM echo Cleaning Edge cache...
REM set "EDGE=%USER_HOME%\AppData\Local\Microsoft\Edge\User Data"

REM for /d %%p in ("%EDGE%\Profile*") do (
    REM call :CleanFolder "%%p\Cache"
    REM call :CleanFolder "%%p\Code Cache"
    REM call :CleanFolder "%%p\GPUCache"
    REM call :CleanFolder "%%p\Service Worker\CacheStorage"
REM )

REM call :CleanFolder "%EDGE%\Default\Cache"
REM call :CleanFolder "%EDGE%\Default\Code Cache"
REM call :CleanFolder "%EDGE%\Default\GPUCache"
REM call :CleanFolder "%EDGE%\Default\Service Worker\CacheStorage"

=========================================
VISUAL STUDIO CACHE
=========================================

REM echo.
REM echo Cleaning Visual Studio cache...
REM for /d %%v in ("%USER_HOME%\AppData\Local\Microsoft\VisualStudio\*") do (
    REM call :CleanFolder "%%v\ComponentModelCache"
    REM call :CleanFolder "%%v\JSProjectSystem"
    REM call :CleanFolder "%%v\WebTools"
REM )

=========================================
VS CODE CACHE
=========================================

REM echo.
REM echo Cleaning VS Code cache...
REM call :CleanFolder "%USER_HOME%\AppData\Roaming\Code\Cache"
REM call :CleanFolder "%USER_HOME%\AppData\Roaming\Code\Code Cache"
REM call :CleanFolder "%USER_HOME%\AppData\Roaming\Code\CachedData"
REM call :CleanFolder "%USER_HOME%\AppData\Roaming\Code\CachedExtensionVSIXs"

=========================================
JETBRAINS CACHE
=========================================

REM echo.
REM echo Cleaning JetBrains cache...
REM for /d %%j in ("%USER_HOME%\AppData\Local\JetBrains\*") do (
    REM call :CleanFolder "%%j\caches"
REM )

=========================================
PACKAGE MANAGER CACHES
=========================================

REM echo.
REM echo Cleaning package manager caches...
REM call :CleanFolder "%USER_HOME%\AppData\Local\npm-cache"
REM call :CleanFolder "%USER_HOME%\AppData\Roaming\npm-cache"
REM call :CleanFolder "%USER_HOME%\AppData\Local\Yarn\Cache"
REM call :CleanFolder "%USER_HOME%\AppData\Local\pip\Cache"
REM call :CleanFolder "%USER_HOME%\AppData\Local\NuGet\Cache"
REM call :CleanFolder "%USER_HOME%\AppData\Local\AzureFunctionsTools"

=========================================
USER TEMP (FILES + SUBFOLDERS, KEEP ROOT)
=========================================

REM echo.
REM echo Cleaning User Temp (files and subfolders)...
REM if exist "%USER_HOME%\AppData\Local\Temp" (
    REM del /f /s /q "%USER_HOME%\AppData\Local\Temp\*" 2>nul
    REM for /d %%x in ("%USER_HOME%\AppData\Local\Temp\*") do (
        REM rd /s /q "%%x" 2>nul
    REM )
REM )

=========================================
THUMBNAIL CACHE
=========================================

REM echo.
REM echo Cleaning thumbnail cache...
REM del /f /q "%USER_HOME%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul

=========================================
WINDOWS ERROR REPORTS
=========================================

REM echo.
REM echo Cleaning Windows Error Reports...
REM call :CleanFolder "%USER_HOME%\AppData\Local\Microsoft\Windows\WER"

=========================================
ADMIN-ONLY CLEANUPS
=========================================

REM if "!IS_ADMIN!"=="1" (

    --- System WER ---
    REM call :CleanFolder "C:\ProgramData\Microsoft\Windows\WER\ReportQueue"

    --- Windows Temp (contents only, keep root) ---
    REM echo.
    REM echo Cleaning Windows Temp...
    REM if exist "C:\Windows\Temp" (
        REM del /f /s /q "C:\Windows\Temp\*" 2>nul
        REM for /d %%x in ("C:\Windows\Temp\*") do (
            REM rd /s /q "%%x" 2>nul
        REM )
    REM )

    --- Windows Update Cache ---
    REM echo.
    REM echo Cleaning Windows Update cache...
    REM net stop wuauserv >nul 2>&1
    REM call :CleanFolder "C:\Windows\SoftwareDistribution\Download"
    REM net start wuauserv >nul 2>&1

REM ) else (
    REM echo.
    REM echo Skipping admin-level cleanups ^(run as Administrator to enable^).
REM )

=========================================
DOCKER CLEANUP (SAFE GUARD)
=========================================

REM where docker >nul 2>&1
REM if !errorlevel!==0 (
    REM docker info >nul 2>&1
    REM if !errorlevel!==0 (
        REM echo.
        REM echo Running Docker system prune...
        REM docker system prune -f
    REM ) else (
        REM echo.
        REM echo Docker installed, but the daemon is not running. Skipping prune.
    REM )
REM )

=========================================
COMPLETE
=========================================

REM echo.
REM echo ========================================
REM echo  Cleanup Completed Successfully
REM echo  Restart your machine, recommended.
REM echo ========================================
REM echo.
REM pause
REM exit /b 0

=========================================
FUNCTION: CleanFolder
Deletes folder contents and recreates it.
Safe for cache/non-system folders only.
=========================================

REM :CleanFolder
REM if exist "%~1" (
    REM echo   Cleaning: %~1
    REM rd /s /q "%~1" 2>nul
    REM mkdir "%~1" 2>nul
REM )
REM exit /b 0
