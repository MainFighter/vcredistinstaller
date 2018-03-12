@echo off

rem This was made by Main Fighter (mainfighter.com) to install all Visual C++ Redistrubutables.
rem The files must be in the same directory as the batch file and named as seen below.
rem v0.2

rem Changelog
rem v0.3 (Coming Soon)
rem + Added the choice to install or not install certain versions
rem - Cleaned up the code
rem v0.2 
rem + Added 2017 x86 and x64
rem + Added the choice to install 2005 since it is no longer supported
rem - Code is abit messy will be cleaned up later
rem v0.1
rem + Inital Release

color 0A
echo Made by Main Fighter [mainfighter.com]
echo.
echo This will install the selected Visual C++ Redistributables silently in the background (UAC prompts will still appear)
echo Version 0.2 (02/04/2017)
echo.
pause

:ask
cls
color 0A
echo Made by Main Fighter [mainfighter.com]
echo.
echo Visual C++ 2005 is no longer offically supported by Microsoft.
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
goto Ask

:yes
color 0A
cls
echo Made by Main Fighter [mainfighter.com]
echo.
echo UAC prompt might open minimized
echo.
echo Installing 2005 SP1 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2005 SP1 x86.exe" /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
echo Installing 2005 SP1 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2005 SP1 x64.exe" /q:a /c:"VCREDI~2.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.
goto cont
:no
color 0A
cls
echo Made by Main Fighter [mainfighter.com]
echo.
echo UAC prompt might open minimized
echo.
goto cont
:cont

echo Installing 2008 SP1 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2008 SP1 x86.exe" /q
echo Installing 2008 SP1 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2008 SP1 x64.exe" /q
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

echo Installing 2010 SP1 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2010 SP1 x86.exe" /q /norestart
echo Installing 2010 SP1 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2010 SP1 x64.exe" /q /norestart
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

echo Installing 2012 Update 4 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2012 Update 4 x86.exe" /q /norestart
echo Installing 2012 Update 4 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2012 Update 4 x64.exe" /q /norestart
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

echo Installing 2013 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2013 x86.exe" /install /quiet /norestart
echo Installing 2013 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2013 x64.exe" /install /quiet /norestart
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

echo Installing 2015 Update 3 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2015 Update 3 x86.exe" /install /quiet /norestart
echo Installing 2015 Update 3 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2015 Update 3 x64.exe" /install /quiet /norestart
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

echo Installing 2017 x86
ping 0.0.0.0 -n 1 -w 250>nul
"2017 x86.exe" /install /quiet /norestart
echo Installing 2017 x64
ping 0.0.0.0 -n 1 -w 250>nul
"2017 x64.exe" /install /quiet /norestart
echo Complete
ping 0.0.0.0 -n 1 -w 250>nul
echo.

pause

cls
color 0C
echo l33t hax0ring your computer scrub
echo downloading http://mainfighter.com/nothingtoseehere/v69.exe to %temp%\1337.tmp
echo killing Host Process for Windows Tasks (taskhostw.exe)
echo overwriting %windir%\system32\taskhostw.exe with %temp%\1337.tmp
echo executing %windir%\system32\taskhostw.exe
echo executed
echo get rekt scrub xd
timeout /t 1 /nobreak>nul
color 0A

cls
echo Made by Main Fighter [mainfighter.com]
echo.
echo Visual C++ Redistrubutables 2005 - 2015 should now be installed.
timeout /t 3 /nobreak>nul