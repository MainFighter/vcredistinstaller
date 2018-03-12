@echo off

set VER=0.4.1
set FINTIME=XX:XXAM
set FINDATE=28/02/2018
set TIMEZONE=AEST

rem This was made by Main Fighter (mainfighter.com) to install all Visual C++ Redistrubutables.
rem The installation files must be in the same directory as the batch file and named as seen below.

rem Changelog
rem + Patched elevate privileges
rem - Will now mount share as soon as the script is launched

rem Mounts drive
pushd %~dp0

:CheckAdminRights
rem Sets UAC to place that the scripts gets put temp
set UAC="%temp%\mf_getadmin.vbs"
rem Create script to get admin rights
fltmc >nul 2>&1 || (title Requesting Admin Privileges & (echo Set UAC=CreateObject^("Shell.Application"^):UAC.ShellExecute "%~f0","","","runas",1)>%UAC% & %UAC% & del /f /q %UAC% & exit)

title Install Visual C++ Redistributables

rem Mounts drive
pushd %~dp0

color 0A
echo Made by Main Fighter [mainfighter.com]
echo Version %VER% (%FINDATE%)
echo.
echo This will install the selected Visual C++ Redistributables silently in the background
echo.
pause

:ask
cls
color 0A
echo Made by Main Fighter [mainfighter.com]
echo Version %VER% (%FINDATE%)
echo.
echo Visual C++ 2005 is no longer offically supported by Microsoft as of April 12th 2016.
echo Do you want to install it? (y/n)
set INPUT=
set /P INPUT=Type input: %=%
If /I "%INPUT%"=="y" goto yes 
If /I "%INPUT%"=="n" goto no
cls
color 0C
echo.
echo Incorrect input please try again
timeout /t 3 /nobreak>nul
goto ask

:yes
color 0A
cls
echo Made by Main Fighter [mainfighter.com]
echo Version %VER% (%FINDATE%)
echo.
echo Installing 2005 SP1 x86
"2005 SP1 x86.exe" /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
echo Installing 2005 SP1 x64
"2005 SP1 x64.exe" /q:a /c:"VCREDI~2.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
echo Complete
echo.
goto cont
:no
color 0A
cls
echo Made by Main Fighter [mainfighter.com]
echo Version %VER% (%FINDATE%)
echo.
goto cont
:cont

echo Installing 2008 SP1 x86
"2008 SP1 x86.exe" /q
echo Installing 2008 SP1 x64
"2008 SP1 x64.exe" /q
echo Complete
echo.

echo Installing 2010 SP1 x86
"2010 SP1 x86.exe" /q /norestart
echo Installing 2010 SP1 x64
"2010 SP1 x64.exe" /q /norestart
echo Complete
echo.

echo Installing 2012 Update 4 x86
"2012 Update 4 x86.exe" /q /norestart
echo Installing 2012 Update 4 x64
"2012 Update 4 x64.exe" /q /norestart
echo Complete
echo.

echo Installing 2013 x86
"2013 x86.exe" /install /quiet /norestart
echo Installing 2013 x64
"2013 x64.exe" /install /quiet /norestart
echo Complete
echo.

echo Installing 2015 Update 3 x86
"2015 Update 3 x86.exe" /install /quiet /norestart
echo Installing 2015 Update 3 x64
"2015 Update 3 x64.exe" /install /quiet /norestart
echo Complete
echo.

echo Installing 2017 x86
"2017 x86.exe" /install /quiet /norestart
echo Installing 2017 x64
"2017 x64.exe" /install /quiet /norestart
echo Complete
echo.

rem This will remove any mounted drives used
popd

timeout /t 1 /nobreak>nul

cls
echo Made by Main Fighter [mainfighter.com]
echo Version %VER% (%FINDATE%)
echo.
echo Selected Visual C++ Redistrubutables should now be installed :)
timeout /t 3 /nobreak>nul