@echo off
color 0A
echo Made by Main Fighter [mainfighter.com]
echo.
rem This was made by Main Fighter (mainfighter.com) to install all Visual C++ Redistrubutables.
rem The files must be in the same directory as the batch file and named as seen below.
echo This will install all Visual C++ Redistributables silently in the background (UAC prompts will still appear)
echo Last updated 31/03/2017
echo.
pause

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