@echo off
rem Listing currently running unsigned processes

cd %~dp0
if not exist sigcheck.exe goto :nosigcheck
set "s='PowerShell "Get-Process * ^| Format-List Path"'"
for /F "tokens=2* delims= " %%i in  (%s%) do call :checkitem "%%j"
exit

:checkitem
if "%~1" == ""  exit /b
for /f "tokens=*" %%f in ('sigcheck -v -u -q %1') do call :checksig "%%~f"
exit /b

:checksig
if "%~1"=="No matching files were found."  exit /b
if "%~1"=="Path,Verified,Date,Publisher,Description,Product,Version,File version"  exit /b
echo %~1
exit /b

:nosigcheck
echo No sigcheck.exe found in this cmd file directory, need it to function properly. https://docs.microsoft.com/en-us/sysinternals/downloads/sigcheck >&2
exit -1