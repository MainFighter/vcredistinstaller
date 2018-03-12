:: mainfighter.com
:: Version 1.0.0alpha2 (02/03/2018)

@echo off
pushd %~dp0

:CheckAdminRights
:: Sets UAC to place that the scripts gets put temp
set UAC="%temp%\mfvcinstall_getadmin.vbs"
:: Create script to get admin rights
fltmc >nul 2>&1 || (title Requesting Admin Privileges & (echo Set UAC=CreateObject^("Shell.Application"^):UAC.ShellExecute "%~f0","","","runas",1)>%UAC% & %UAC% & del /f /q %UAC% & exit)

:: Debug mode, basically should always be false unless you are using it
set debug=true

:: Information
set localversion=1.0.0alpha2
set releasetime=XX:XX
set releasedate=02/03/2018
set timezone=AEST

:: Customize
set cmdcolor=0A
set cmdtitle=mainfighter.com - Download and Installer for Visual C++ Redistributables - %localversion%

:: Displayed welcome screen that is at the bottom
call :WelcomeScreen
pause

:: Remote URLs
set versionurl=https://mainfighter.com/scripts/vcredistinstaller/remote/version.txt
set vcredisturl=https://mainfighter.com/scripts/vcredistinstaller/remote/vcredist

:: VC++ Redist versions
set vcredistdir=vcredist
set vcredist05_32=vcredist_2005_win32.exe
set vcredist05_64=vcredist_2005_win64.exe
set vcredist08_32=vcredist_2008_win32.exe
set vcredist08_64=vcredist_2008_win64.exe
set vcredist10_32=vcredist_2010_win32.exe
set vcredist10_64=vcredist_2010_win64.exe
set vcredist12_32=vcredist_2012_win32.exe
set vcredist12_64=vcredist_2012_win64.exe
set vcredist13_32=vcredist_2013_win32.exe
set vcredist13_64=vcredist_2013_win64.exe
set vcredist15_32=vcredist_2015_win32.exe
set vcredist15_64=vcredist_2015_win64.exe
set vcredist17_32=vcredist_2017_win32.exe
set vcredist17_64=vcredist_2017_win64.exe

pushd %~dp0

:CheckArchitecture
:: Check architecture in registry
reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" | find /i "AMD64" >nul && set arch=64 || set arch=32

:: Use wget on proper architecture
if %arch%==64 set wget=bin\wget_win64.exe
if %arch%==32 set wget=bin\wget_win32.exe

:CheckVersion
echo Checking Version
echo.
set versioncheck=%temp%\mfvcinstall_version.txt
:: Download version.txt for version checking
%wget% --no-check-certificate -O %versioncheck% %versionurl% >nul 2>&1
:: Set remoteversion
for /f "delims=" %%a in (%versioncheck%) do set remoteversion=%%a
:: Remove version.txt
if exist %versioncheck% del /f /q %versioncheck% >nul 2>&1
cls

:DownloadVCRedist
call :Header

echo Downloading latest VC++ Redistubutables
echo.
if not exist vcredist mkdir vcredist 
::%wget% -r --no-check-certificate -np -nd -N -R "index.html*" -P %vcredistdir% %vcredisturl% >nul 2>&1

:: Downloader for 64 bit system
if %debug%==off (
    if %arch%==64 (
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist05_32% %vcredisturl%/%vcredist05_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist05_64% %vcredisturl%/%vcredist05_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist08_32% %vcredisturl%/%vcredist08_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist08_64% %vcredisturl%/%vcredist08_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist10_32% %vcredisturl%/%vcredist10_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist10_64% %vcredisturl%/%vcredist10_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist12_32% %vcredisturl%/%vcredist12_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist12_64% %vcredisturl%/%vcredist12_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist13_32% %vcredisturl%/%vcredist13_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist13_64% %vcredisturl%/%vcredist13_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist15_32% %vcredisturl%/%vcredist15_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist15_64% %vcredisturl%/%vcredist15_64% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist17_32% %vcredisturl%/%vcredist17_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist17_64% %vcredisturl%/%vcredist17_64% >nul 2>&1
    )

    :: Download for 32 bit system
    if %arch%==32 (
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist05_32% %vcredisturl%/%vcredist05_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist08_32% %vcredisturl%/%vcredist08_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist10_32% %vcredisturl%/%vcredist10_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist12_32% %vcredisturl%/%vcredist12_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist13_32% %vcredisturl%/%vcredist13_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist15_32% %vcredisturl%/%vcredist15_32% >nul 2>&1
        %wget% --no-check-certificate -N -O %vcredistdir%\%vcredist17_32% %vcredisturl%/%vcredist17_32% >nul 2>&1
    )
)

cls

:InstallVCRedist
call :Header

:: Install for 64 bit system
if %debug%==false (
    if %arch%==64 (
        echo Installing Visual C++ Redistributable 2005 x86
        %vcredistdir%\%vcredist05_32% /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
        echo Installing Visual C++ Redistributable 2005 x64
        %vcredistdir%\%vcredist05_64% /q:a /c:"VCREDI~2.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "

        echo Installing Visual C++ Redistributable 2008 x86
        %vcredistdir%\%vcredist08_32% /q
        echo Installing Visual C++ Redistributable 2008 x64
        %vcredistdir%\%vcredist08_64% /q

        echo Installing Visual C++ Redistributable 2010 x86
        %vcredistdir%\%vcredist10_32% /q /norestart
        echo Installing Visual C++ Redistributable 2010 x64
        %vcredistdir%\%vcredist10_64% /q /norestart

        echo Installing Visual C++ Redistributable 2012 x86
        %vcredistdir%\%vcredist12_32% /q /norestart
        echo Installing Visual C++ Redistributable 2012 x64
        %vcredistdir%\%vcredist12_64% /q /norestart

        echo Installing Visual C++ Redistributable 2013 x86
        %vcredistdir%\%vcredist13_32% /install /quiet /norestart
        echo Installing Visual C++ Redistributable 2013 x64
        %vcredistdir%\%vcredist13_64% /install /quiet /norestart

        echo Installing Visual C++ Redistributable 2015 x86
        %vcredistdir%\%vcredist15_32% /install /quiet /norestart
        echo Installing Visual C++ Redistributable 2015 x64
        %vcredistdir%\%vcredist15_64% /install /quiet /norestart

        echo Installing Visual C++ Redistributable 2017 x86
        %vcredistdir%\%vcredist17_32% /install /quiet /norestart
        echo Installing Visual C++ Redistributable 2017 x64
        %vcredistdir%\%vcredist17_64% /install /quiet /norestart
    )

    :: Install for 32 bit system
    if %arch%==32 (
        echo Installing Visual C++ Redistributable 2005 x86
        %vcredistdir%\%vcredist05_32% /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "

        echo Installing Visual C++ Redistributable 2008 x86
        %vcredistdir%\%vcredist08_32% /q

        echo Installing Visual C++ Redistributable 2010 x86
        %vcredistdir%\%vcredist10_32% /q /norestart

        echo Installing Visual C++ Redistributable 2012 x86
        %vcredistdir%\%vcredist12_32% /q /norestart

        echo Installing Visual C++ Redistributable 2013 x86
        %vcredistdir%\%vcredist13_32% /install /quiet /norestart

        echo Installing Visual C++ Redistributable 2015 x86
        %vcredistdir%\%vcredist15_32% /install /quiet /norestart

        echo Installing Visual C++ Redistributable 2017 x86
        %vcredistdir%\%vcredist17_32% /install /quiet /norestart
    )
)

:Debug
if %debug%==true (
    if %arch%==64 (
        echo Architecture is x64
        echo Simulated Install Visual C++ Redistributable
        timeout /t 3 /nobreak >nul
        echo Simulated Install Visual C++ Redistributable
        timeout /t 3 /nobreak >nul
    )
    if %arch%==32 (
        echo Architecture is x86"
        echo Simulated Install Visual C++ Redistributable
        timeout /t 3 /nobreak >nul
        echo Simulated Install Visual C++ Redistributable
        timeout /t 3 /nobreak >nul
    )
)

:WelcomeScreen
title %cmdtitle%
color %cmdcolor%
echo Made by Main Fighter [mainfighter.com]
echo Version %localversion% (%releasedate%)
echo.
echo This will install the selected Visual C++ Redistributables silently in the background
echo.
goto :eof

:Header
title %cmdtitle%
color %cmdcolor%
echo Made by Main Fighter [mainfighter.com]
echo Version %localversion% (%releasedate%)
echo.
goto :eof

:Footer
goto :eof