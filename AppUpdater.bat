@echo off
title App Updater
:back
cd /d "%~dp0"
echo Checking for software . . ., %date%, %time% >> UpdateLog.txt
winget > nul
if %ErrorLevel%==1 goto DownLdWget
echo Checking for Updates . . . , %date%, %time% >> UpdateLog.txt
winget upgrade >> UpdateLog.txt
winget upgrade > "%temp%\AppUpdater.tmp"
echo Updates are available for the following programs: 
type "%temp%\AppUpdater.tmp"
echo Do you want to update ALL the apps (Y/N)?
set /p a=
echo var 'a' = '%a%' >> UpdateLog.txt
if "%a%"=="y" goto y
if "%a%"=="Y" goto y
goto n
:y
winget upgrade --all >> UpdateLog.txt
winget upgrade >> UpdateLog.txt
start notepad UpdateLog.txt
exit /B
:n
cls
winget upgrade
:z
set /P ID=Type the ID of the program you want to update (type nothing if you do not want to update any apps): 
echo var 'ID' = '%ID%' >> UpdateLog.txt
if "%ID%"=="" goto xit
winget upgrade "%ID%" >> UpdateLog.txt
set /p moreapps=Do you want to update more apps (Y/N)?
echo var 'moreapps' = '%moreapps%" >> UpdateLog.txt
if "%moreapps%"=="y" goto z
if "%moreapps%"=="Y" goto z
start notepad UpdateLog.txt
exit /B
:DownLdWget
cd /d "%temp%"
powershell -Command "Start-BitsTransfer https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" >> UpdateLog.txt
Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
goto back
:xit
echo No updates installed >> UpdateLog.txt
