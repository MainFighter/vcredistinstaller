:: mainfighter.com
:: Version 1.0.0beta2 (02/03/2018)

@echo off
pushd %~dp0

:CheckAdminRights
:: Sets UAC to place that the scripts gets put temp
set UAC="%temp%\mfvcinstall_getadmin.vbs"
:: Create script to get admin rights
fltmc >nul 2>&1 || (title Requesting Admin Privileges & (echo Set UAC=CreateObject^("Shell.Application"^):UAC.ShellExecute "%~f0","","","runas",1)>%UAC% & %UAC% & del /f /q %UAC% & exit)
pushd %~dp0

:: Information
set author=Main Fighter
set website=mainfighter.com
set localversion=1.0.0beta2
set releasetime=21:59
set releasedate=02/03/2018
set timezone=AEST

:: Customize
set cmdtitle=%website% - Download and Installer for Visual C++ Redistributables - %localversion%
set cmdcolor=0A

:: Debug mode, basically should always be false unless you are using it
set debug=true

:: Keep chace, if set to false it will remove the downloaded VC++ Redistributable files
set keepcache=true

:: VC++ Redist Download, if set to false will disable the script from downloadng VC++ Redistrubutable files
:: If you disable this option you will have to download and rename the .exe files manually
set vcredistdownload=true

:: Version Check, if set to false will disable version check
set versioncheck=true

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

:: Displayed welcome screen that is at the bottom
call :WelcomeScreen
pause
cls

::===============================================================================================================::

:CheckArchitecture
:: Check architecture in registry
reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" | find /i "AMD64" >nul && set arch=64 || set arch=32

::===============================================================================================================::

:Wget
:: Use wget on proper architecture
if %arch%==64 set wget=bin\wget_win64.exe
if %arch%==32 set wget=bin\wget_win32.exe

::===============================================================================================================::

:CheckVersion
if %versioncheck%==false goto :ChooseVersions
call :Header

echo Checking Version
echo.
set versionfile=%temp%\mcvcinstall_version.txt
:: Download version.txt for version checking
%wget% --no-check-certificate --output-document=%versionfile% %versionurl% >nul 2>&1
:: Set remoteversion
for /f "delims=" %%a in (%versionfile%) do set remoteversion=%%a
:: Remove version.txt
if exist %versionfile% del /f /q %versionfile% >nul 2>&1

echo Local Version: %localversion%
echo Remote Version: %remoteversion%
timeout /t 3 /nobreak >nul

cls

::===============================================================================================================::

:ChooseVersions
call :Header

:ask2005
echo Visual C++ 2005 is no longer offically supported by Microsoft as of April 12th 2016.
echo Do you want to install it? (y/n)
set input=
set /P input=Type input: %=%
If /I %input%==y set install05=true & goto correct
If /I %input%==n set install05=false & goto correct
echo Incorrect input please try again
timeout /t 3 /nobreak >nul
goto ask2005
:correct

cls

::===============================================================================================================::

:DownloadVCRedist

if %vcredistdownload%==true (
    call :Header

    echo Downloading latest VC++ Redistubutables
    echo Download status can be seen in the title of the window
    echo.
    if not exist %vcredistdir% md %vcredistdir%

    :: Downloader for 64 bit system
    if %debug%==false (
        if %arch%==64 (
            if %install05%==true (
                %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist05_32% >nul 2>&1
                %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir%%vcredist05_64% %vcredisturl%/%vcredist05_64% >nul 2>&1
            )
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_64% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_64% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_64% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_64% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_64% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_64% >nul 2>&1
        )
        :: Download for 32 bit system
        if %arch%==32 (
            if %install05%==true (
                %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist05_32% >nul 2>&1
            )
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_32% >nul 2>&1
            %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_32% >nul 2>&1
        )
    )

cls
)

::===============================================================================================================::

:InstallVCRedist
call :Header

:: Install for 64 bit system
if %debug%==false (
    if %arch%==64 (
        if %install05%==true (
            echo Installing Visual C++ Redistributable 2005 x86
            %vcredistdir%\%vcredist05_32% /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
            echo Installing Visual C++ Redistributable 2005 x64
            %vcredistdir%\%vcredist05_64% /q:a /c:"VCREDI~2.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
        )

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
        if %install05%==true (
            echo Installing Visual C++ Redistributable 2005 x86
            %vcredistdir%\%vcredist05_32% /q:a /c:"VCREDI~3.EXE /q:a /c:""msiexec /i vcredist.msi /qn"" "
        )

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

cls

::===============================================================================================================::

:RemoveCache
call :Header

if %keepcache%==false (
    echo Removing downloaded VC++ Redistributable files
    rd /s /q %vcredistdir%
)

cls

::===============================================================================================================::

:Debug
call :Header

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

::===============================================================================================================::

cls
call :FarewellScreen
popd
timeout /t 3 /nobreak >nul
exit

::===============================================================================================================::

:WelcomeScreen
title %cmdtitle%
color %cmdcolor%
echo Made by %author% [%website%]
echo Version: %localversion% (%releasedate%)
echo.
echo This will install the selected Visual C++ Redistributables silently in the background
echo.
goto :eof

::===============================================================================================================::

:Header
title %cmdtitle%
color %cmdcolor%
echo Made by %author% [%website%]
echo Version: %localversion% (%releasedate%)
echo.
goto :eof

::===============================================================================================================::

:Footer
goto :eof

::===============================================================================================================::

:FarewellScreen
title %cmdtitle%
color %cmdcolor%
echo Made by %author% [%website%]
echo Version: %localversion% (%releasedate%)
echo.
echo Selected Visual C++ Redistrubutables should now be installed :)
goto :eof