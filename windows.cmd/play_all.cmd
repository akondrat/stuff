@echo off
rem Create and start a playlist with the audio files from specified directory
if "%~1"=="" (goto :noarg)
cd %~dp0

echo ^[playlist^] >pls.pls
set /a cnt=1
for /F "delims=" %%f in ('dir %1\*.mp3 %1\*.mp4 %1\*.m4a /b /s') do call :item "%%f"
echo NumberOfEntries=%cnt% >>pls.pls
echo Version=2 >>pls.pls

start pls.pls
exit

:item

echo File%cnt%="%~1" >>pls.pls
set /a cnt=cnt+1
exit /b

:noarg
echo No dir provided.
exit -1
