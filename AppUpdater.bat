@echo off
title App Updater
:back
cd /d "%~dp0"
echo Checking for software . . ., %date%, %time% >> UpdateLog.txt
winget > nul
if %ErrorLevel%==1 goto DownLdWget
echo Checking for Updates . . . , %date%, %time% >> UpdateLog.txt
winget upgrade >> UpdateLog.txt
winget upgrade --all >> UpdateLog.txt
winget upgrade >> UpdateLog.txt
CScript.exe //NoLogo WINDOWS.VBS >> UpdateLog.txt
exit /B
:DownLdWget
cd /d "%temp%"
powershell -Command "Start-BitsTransfer https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" >> UpdateLog.txt
Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
goto back