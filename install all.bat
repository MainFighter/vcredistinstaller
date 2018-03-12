@echo off

rem This was made by Main Fighter (mainfighter.com) to install all Visual C++ Redistrubutables.
rem The installation files must be in the same directory as the batch file and named as seen below.
rem Version v0.3.3 (Completed 11:08PM 18/08/2017)

rem Changelog
rem In the works
rem + Adding the choice to install or not install certain versions
rem + Making it so the script automatically elevates its permissions with a single UAC prompt at the beginning (if possible)
rem + Cleaning up the messy code
rem v0.3.3
rem - Change mount location to be after first screen
rem v0.3.2
rem + Corrected ask
rem - Spelling mistake
rem v0.3.1
rem + Patched demounting shared folder
rem v0.3
rem + Will work off shared folders now
rem - Merged _shares and _local because the share code works both on a share and local drive
rem v0.2.3_shares
rem + Added the ability to use from a network share by temporarily mounting the drive
rem v0.2.3
rem - Remove pointless delays
rem v0.2.2
rem + Fixed typos
rem - Removed left over pause in the middle of the script from debugging
rem - Removed some other left over debugging shit
rem v0.2.1
rem + Added the ability to run the batch file in Administrator mode to stop UAC prompts
rem + Fixed spelling mistakes and updated text at the end
rem v0.2 
rem + Added 2017 x86 and x64
rem + Added the choice to install 2005 since it is no longer supported
rem - Code is abit messy will be cleaned up later
rem v0.1
rem + Inital Release

rem cd %~dp0
cls

color 0A
echo Made by Main Fighter [mainfighter.com]
echo.
echo This will install the selected Visual C++ Redistributables silently in the background (UAC prompts will still appear)
echo You can stop the UAC prompts by running the .bat file in Administrator mode
echo Version 0.3.3 (18/08/2017)
echo.
pause

rem This should mount a network share if it is being installed from there
pushd %~dp0

:ask
cls
color 0A
echo Made by Main Fighter [mainfighter.com]
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
echo.
echo UAC prompt might open minimized
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
echo.
echo UAC prompt might open minimized
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
echo Selected Visual C++ Redistrubutables should now be installed :)
timeout /t 3 /nobreak>nul