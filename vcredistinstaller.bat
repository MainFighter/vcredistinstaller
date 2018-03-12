:: Made by Main Fighter [mainfighter.com]
:: Visual C++ Redistrubutable Download and Installer script
:: Version 1.0.0rc1 (02/03/2018)

@echo off
pushd %~dp0

:CheckAdminRights
:: Sets UAC to place that the scripts gets put temp
set uac=%temp%\mfvcinstall_getadmin.vbs
:: Create script to get admin rights
fltmc >nul 2>&1 || (title Requesting Admin Privileges & (echo Set UAC=CreateObject^("Shell.Application"^):UAC.ShellExecute "%~f0","","","runas",1)>%uac% & %uac% & del /f /q %uac% & exit)
pushd %~dp0

:: Information
set author=Main Fighter
set website=mainfighter.com
set projectname=vcredistinstaller
set detailedname=Download and Installer for VC++ Redists
set localversion=1.0.0rc1
set releasetime=14:08
set releasedate=03/03/2018
set timezone=AEST

:: Customize
set cmdtitle=%website% - %detailedname% - %localversion%
set cmdcolor=0A

:: Version Check, if set to false will disable version check
set versioncheck=true

:: Visual C++ Redistributable Download, if set to false will disable the script from downloadng Visual C++ Redistributable files
:: If you disable the auto download you will have to manually download and place the files in the correct folder
:: You can change the name of the folder and files below or just rename the exes to the default folder and exe names
set vcredistdownload=true

:: Keep cache, if set to false it will remove the downloaded Visual C++ Redistributable files on completion
set keepcache=true

:: Debug mode, basically should always be false unless you are using it
set debug=true

:: Remote URLs
:: You can change the URLs to your own if you like
set scripturl=https://%website%/scripts/%projectname%
set versionurl=https://%website%/scripts/%projectname%/remote/version.txt
set vcredisturl=https://%website%/scripts/%projectname%/remote/vcredist

:: Visual C++ Redistributable versions
:: vcredistdir is the name of the folder the files are store in on the local machine
set vcredistdir=vcredist
:: These only change what they are called on the server not what they are called on the local machine
:: This was changed due to timestamping on files
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

:CheckWindowsVersion
:: Will be impmented in future
:: Currently only used for debug screen
set osver=ver

::===============================================================================================================::

:CheckArchitecture
:: Check architecture in registry
reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" | find /i "AMD64" >nul && set arch=64 || set arch=32

::===============================================================================================================::

:Wget
:: Use wget win64 on 64bit system
if %arch%==64 set wget=bin\wget_win64.exe
:: Use wget win32 on 32bit system
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

if /i %localversion%==%remoteversion% (
    goto :noupdate
) else (
    cls
    call :Header
    color CF
    echo Version out of date
    echo Local Version: %localversion%
    echo Remote Version: %remoteversion%
    echo Download at %scripturl%
    echo.
    pause
    cls
    goto :ChooseVersions
)

:noupdate
echo Local Version: %localversion%
echo Remote Version: %remoteversion%
timeout /t 3 /nobreak >nul

cls

::===============================================================================================================::

:ChooseVersions
call :Header

:ask2005
echo Visual C++ Redistributables 2005 are no longer offically supported by Microsoft as of April 12th 2016.
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

if %debug%==true goto :Debug
if %vcredistdownload%==false goto :InstallVCRedist

call :Header

echo Downloading latest Visual C++ Redistributables
echo Download status can be seen in the title of the window
echo.
if not exist %vcredistdir% md %vcredistdir%

:: Download for 64bit system
if %arch%==64 (
    if %install05%==true (
        echo Downloading Visual C++ Redistributable 2005 x86
        %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist05_32% >nul 2>&1
        echo Downloading Visual C++ Redistributable 2005 x64
        %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist05_64% >nul 2>&1
    )
    echo Downloading Visual C++ Redistributable 2008 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2008 x64
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_64% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2010 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2010 x64
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_64% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2012 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2012 x64
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_64% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2013 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2013 x64
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_64% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2015 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2015 x64
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_64% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2017 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_32% >nul 2>&1
    echo Downloading Visual C++ Redistributable 2017 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_64% >nul 2>&1
)

:: Download for 32bit system
if %arch%==32 (
    if %install05%==true (
        echo Downloading Visual C++ Redistributable 2005 x86
        %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist05_32% >nul 2>&1
    )
    echo Downloading Visual C++ Redistributable 2008 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist08_32% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2010 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist10_32% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2012 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist12_32% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2013 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist13_32% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2015 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist15_32% >nul 2>&1

    echo Downloading Visual C++ Redistributable 2017 x86
    %wget% --no-check-certificate --timestamping --directory-prefix=%vcredistdir% %vcredisturl%/%vcredist17_32% >nul 2>&1
)

cls

::===============================================================================================================::

:InstallVCRedist
call :Header

echo Installing latest Visual C++ Redistributables
echo.

:: Install for 64bit system
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

:: Install for 32bit system
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

cls

::===============================================================================================================::

:RemoveCache

if %keepcache%==true goto :Debug

call :Header

echo Removing downloaded Visual C++ Redistributable files
rd /s /q %vcredistdir%

cls

::===============================================================================================================::

:Debug

if %debug%==false goto :Farewell

call :DebugScreen
pause
cls

call :Header
color CF

echo DEBUG MODE ENABLED
echo.
echo Running simulated installations
echo.

if %arch%==64 (
    if %install05%==true (
        echo Simulated Install Visual C++ Redistributable 2005
        timeout /t 3 /nobreak >nul
    )
    echo Simulated Install Visual C++ Redistributable
    timeout /t 3 /nobreak >nul
)
if %arch%==32 (
    if %install05%==true (
        echo Simulated Install Visual C++ Redistributable 2005
        timeout /t 3 /nobreak >nul
    )
    echo Simulated Install Visual C++ Redistributable
    timeout /t 3 /nobreak >nul
)

pause

cls

::===============================================================================================================::

:Farewell
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
echo Selected Visual C++ Redistributables should now be installed :)
goto :eof

::===============================================================================================================::

:DebugScreen
title DEBUG ENABLED %projectname% %localversion%
color CF
echo Made by %author% [%website%]
echo Version: %localversion% (%releasedate%)
echo.
echo DEBUG MODE CURRENTLY ENABLED
echo.
echo author=%author%
echo website=%website%
echo projectname=%projectname%
echo detailedname=%detailedname%
echo localversion=%localversion%
echo releasedate=%releasedate%
echo releasetime=%releasetime%
echo timezone=%timezone%
echo.
echo Windows Version: %osver%
echo System Architecture: %arch%bit
echo.
echo versioncheck=%versioncheck%
echo vcredistdownload=%vcredistdownload%
echo keepcache=%keepcache%
echo debug=%debug%
echo scripturl=%scripturl%
echo versionurl=%versionurl%
echo vcredisturl=%vcredisturl%
echo wget=%wget%
echo.
goto :eof