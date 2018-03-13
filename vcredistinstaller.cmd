:: Made by Main Fighter [mainfighter.com]
:: Visual C++ Redistrubutable Download and Installer script

@echo off
cls
pushd %~dp0

:CheckAdminRights
:: Sets local for elevate script
set uac=%temp%\mfvcinstall_getadmin.vbs
:: Create script to get admin rights
fltmc >nul 2>&1 || (title Requesting Administrator Privileges & color CF & echo Requesting Administrator Privileges... & (echo Set uac=CreateObject^("Shell.Application"^):uac.ShellExecute "%~f0","","","runas",1)>%uac% & %uac% & if exist %uac% del /f /q %uac% & popd & exit)

:: Project Information
:: Author
set author=Main Fighter
:: Offical Website
set website=mainfighter.com
:: Project Name
set projectname=vcredistinstaller
:: Full Project Name
set detailedprojectname=Download and Installer for VC++ Redistributables
:: Current version
set localversion=1.2.9
:: Release Date
set releasedate=13/03/2018
:: Release Time
set releasetime=13:40
:: Author's timezone
set timezone=AEST

:: Customize
:: Changes command prompt window title (doesn't change it on every screen)
set cmdtitle=%website% - %detailedprojectname% - v%localversion%
:: Changes primary command prompt colors
set cmdcolor=0A
:: Changes color on warning screen, used on new version and debug screen currently
set cmdwcolor=CF

:: Version Check, if set to false will disable version check
set versioncheck=true

:: Auto Update, will auto update the script without asking
set autoupdate=false

:: Visual C++ Redistributable Download, if set to false will disable the script from downloadng Visual C++ Redistributable files
:: If you disable the auto download you will have to manually download and place the files in the correct folder
:: You can change the name of the folder and files below or just rename the exes to the default folder and exe names
set vcredistdownload=true

:: Keep cache, if set to false it will remove the downloaded Visual C++ Redistributable files on completion
set keepcache=true

:: Auto restart, will automatically restart system when installation is complete
set disablerestart=false
set autorestart=false

:: Remote URLs
:: You can change the URLs to your own if you like (just make sure you create the right files, you can look at the ones on my server if you are unsure)
set scripturl=https://%website%/scripts/%projectname%
set updateurl=%scripturl%/release
set versionurl=%scripturl%/remote/version.txt
set vcredisturl=%scripturl%/remote/vcredist
set archiver64url=%scripturl%/remote/bin/7za_win64.exe
set archiver32url=%scripturl%/remote/bin/7za_win32.exe

:: Bin Directory, this is where bineries that are need are stored (eg wget)
set bindir=bin

:: vcredistdir is the name of the folder the files are store in on the local machine
set vcredistdir=vcredist

:: Visual C++ Redistributable versions
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

:: Debug and test mode
:: Test mode will simulate installs and some other stuff instead of actually running the script
:: Debug mode will show the debug screen
:: Debug install will still download and install vcredist for real, won't work if test mode is enabled
set testmode=false
set debug=false
set debuginstall=false

::===============================================================================================================::

:: Removing old .bat files because moved to .cmd
:: This be removed in the future
if exist dontremove.txt goto :WelcomeScreen
if exist OPEN_cmd_FILE_NOT_bat_FILE.txt del /f /q OPEN_cmd_FILE_NOT_bat_FILE.txt & if exist %projectname%*.bat del /f /q %projectname%*.bat

::===============================================================================================================::

:WelcomeScreen
:: Displays welcome screen
:: The screens are being called from the bottom of the script
call :WelcomeScreen
pause
cls

::===============================================================================================================::

:CheckWindowsVersion
:: Gets build number from ver
for /f "tokens=4-5 delims=. " %%i in ('ver') do set winbuild=%%i.%%j
:: Sets osver to correct Windows version
if %winbuild%==10.0 set osver=win10
if %winbuild%==6.3 set osver=win81
if %winbuild%==6.2 set osver=win8
if %winbuild%==6.1 set osver=win7
if %winbuild%==6.0 set osver=winvista
:: 5.2 is actually Windows XP Professional x64
if %winbuild%==5.2 set osver=winxp
if %winbuild%==5.1 set osver=winxp

::===============================================================================================================::

:CheckArchitecture
:: Check architecture in registry
reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" | find /i "AMD64" >nul && set arch=64 || set arch=32

::===============================================================================================================::

:Wget
:: Use wget win64 on 64bit system
if %arch%==64 set wget=%bindir%\wget_win64.exe
:: Use wget win32 on 32bit system
if %arch%==32 set wget=%bindir%\wget_win32.exe

:7z
:: Use 7z win64 on 64bit system
if %arch%==64 set archiverurl=%archiver64url% & set archiver=%bindir%\7za_win64.exe
:: Use 7z win32 on 32bit system
if %arch%==32 set archiverurl=%archiver32url% & set archiver=%bindir%\7za_win32.exe

::===============================================================================================================::

:CheckVersion

:: Will skip the version check if it is set to false above
if %versioncheck%==false goto :ChooseVersions

:: Calls the header from the bottom of the script
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

:: Remove points from version numbers
set "localversioncheck=%localversion:.=%"
set "remoteversioncheck=%remoteversion:.=%"

:: Checks if local version is great than remote version. If local is great than remote it calls the PreReleaseScreen, pauses and then continues
if /i %localversioncheck% gtr %remoteversioncheck% cls & title %cmdtitle% & call :PreReleaseScreen & pause & cls & goto :ChooseVersions
:: Determines if local is less than remote and either gotos auto update or continues
if /i %localversioncheck% lss %remoteversioncheck% ( set updateurl=%updateurl%/v%remoteversion%.7z & cls & goto :AutoUpdate ) else ( cls & goto :ChooseVersions )

::===============================================================================================================::

:AutoUpdate

:: If auto update is enabled don't ask about updating
if %autoupdate%==true goto :updatefiles

:askupdatefiles
:: Calls NewVersionScreen from bottom of script
call :NewVersionScreen

echo There is a newer version of the script
echo Do you want to update to the latest version? (y/n)
set input=
set /p input=Type input: %=%
if /i %input%==y goto :updatefiles
if /i %input%==n cls & goto :ChooseVersions
cls
color 0F
echo.
echo Incorrect input please try again
timeout /t 3 /nobreak >nul
cls
goto askupdatefiles

:updatefiles
cls
call :NewVersionScreen

:: Grabs 7z from server
%wget% --no-check-certificate --timestamping --directory-prefix=%bindir% %archiverurl% >nul 2>&1
:: Grabs the latest version from the server
%wget% --no-check-certificate --output-document=v%remoteversion%.7z %updateurl% >nul 2>&1
:: Extracts the latest version and exit
%archiver% x -y v%remoteversion%.7z >nul 2>&1 & if exist v%remoteversion%.7z del /f /q v%remoteversion%.7z & echo Script updated plesae relaunch & timeout /t 3 /nobreak >nul & exit
:: Start updater script
::set runupdaterscript=%temp%\mfvcinstall_updatelaunch.vbs
::echo set up=createobject^("wscript.shell"^):up.run "%~d0\updater.bat")>%runupdaterscript% & %runupdaterscript% & if exist %runupdaterscript% del /f /q %runupdaterscript% & exit

::===============================================================================================================::

:ChooseVersions
call :Header

:ask2005
echo Visual C++ Redistributables 2005 are no longer offically supported by Microsoft as of April 12th 2016.
echo Do you want to install it? (y/n)
set input=
set /p input=Type input: %=%
If /i %input%==y set install05=true & cls & goto DownloadVCRedist
If /i %input%==n set install05=false & cls & goto DownloadVCRedist
cls
color 0C
echo.
echo Incorrect input please try again
timeout /t 3 /nobreak >nul
cls
goto ask2005

::===============================================================================================================::

:DownloadVCRedist

:: If debug is on goto debug screen
if %debug%==true goto :Debug
:: If test mode is on goto test mode
if %testmode%==true goto :Test

:: If vcredistdownload disabled skip to install
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

:: Skips over debug and test mode
cls & goto :RemoveCache

::===============================================================================================================::

:Debug

:: If debug is false goto test mode
if %debug%==false goto :Test
:: If testmode and debuginstall are set to true set the debuginstall to false because they can't both be enabled
if %testmode%==true if %debuginstall%==true set debuginstall=false

call :DebugScreen
pause

:: If debuginstall enabled set debug to false (so it doesn't gets stuck in a loop) and go back to download and install section
if %debuginstall%==true set debug=false & cls & goto :DownloadVCRedist

cls

::===============================================================================================================::

:Test

:: If testmode is disable skip to next part
if %testmode%==false goto :RemoveCache

cls
call :TestHeader
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

echo.
pause

cls

::===============================================================================================================::

:RemoveCache

if %keepcache%==true goto :Farewell

:: If test mode is enabled run simulated cache removable
if %testmode%==true (
    call :TestHeader
    echo Running simulated removable of cache
    echo.

    echo Simulated removable of downloaded Visual C++ Redistributable files
    timeout /t 3 /nobreak >nul

    echo Simulated removable archiver executable
    timeout /t 3 /nobreak >nul
    
    echo.
    pause

    cls & goto :Farewell
)

call :Header

echo Removing downloaded Visual C++ Redistributable files
if exist %vcredistdir% rd /s /q %vcredistdir%

echo Removing archiver executable
if exist %archiver% del /f /q %archiver%

timeout /t 3 /nobreak >nul

cls

::===============================================================================================================::

:Farewell
call :FarewellScreen

if %disablerestart%==true timeout /t 3 /nobreak >nul & popd & exit
if %autorestart%==true cls & goto :Restart

echo Do you want to restart your system? (y/n)
set input=
set /p input=Type input: %=%
If /i %input%==y cls & goto :Restart
If /i %input%==n popd & exit
cls
color 0C
echo.
echo Incorrect input please try again
timeout /t 3 /nobreak >nul
cls 
goto :Farewell

cls

::===============================================================================================================::

:Restart
call :FarewellScreen

:: Test restart
if %testmode%==true ( if %osver%==winxp ( cls & call :TestHeader & echo Shutting down Windows XP & echo. & pause & popd & exit ) else ( cls & call :TestHeader & echo Shutting down Windows Vista and up & echo. & pause & popd & exit ) )

timeout /t 1 /nobreak >nul
echo Your system will restart in 3...
timeout /t 1 /nobreak >nul
echo Your system will restart in 2...
timeout /t 1 /nobreak >nul
echo Your system will restart in 1...
timeout /t 1 /nobreak >nul

:: Restart the system after 02 seconds so it allows time for the script to popd and exit
if %osver%==winxp (shutdown.exe -r -f -t 02 & popd & exit) else ( shutdown.exe /r /f /t 02 & popd & exit )

::===============================================================================================================::

:Header
title %cmdtitle%
color %cmdcolor%
echo %detailedprojectname%
echo Made by %author% [%website%]
echo Version: v%localversion% (%releasedate%)
echo.
goto :eof

::===============================================================================================================::

:Footer
goto :eof

::===============================================================================================================::

:WelcomeScreen
call :Header
echo This will install the selected Visual C++ Redistributables silently in the background
echo.
goto :eof

::===============================================================================================================::

:FarewellScreen
call :Header
echo Selected Visual C++ Redistributables should now be installed :)
echo.
goto :eof

::===============================================================================================================::

:NewVersionScreen
call :Header
color %cmdwcolor%
echo LOCAL VERSION IS OUT OF DATE
echo.
echo Local Version: v%localversion%
echo Remote Version: v%remoteversion%
echo.
goto :eof

::===============================================================================================================::

:PreReleaseScreen
call :Header
color %cmdwcolor%
echo YOU ARE USING A PRE-RELEASE VERSION OF THE SCRIPT
echo.
echo Stable Version: %remoteversion%
echo Local Version: %localversion%
echo.
echo If you encounter any issues please inform %author% [%website%]
echo.
goto :eof

::===============================================================================================================::

:TestHeader
title TEST ENABLED %projectname% v%localversion%
color %cmdwcolor%
echo %projectname% v%localversion%
echo.
echo TEST MODE CURRENTLY ENABLED
echo.
echo Windows Version: %osver%
echo System Architecture: %arch%bit
echo.
goto :eof

::===============================================================================================================::

:DebugScreen
title DEBUG INFORMATION %projectname% v%localversion%
color %cmdwcolor%
echo DEBUG INFORMATION
echo.
echo Windows Version: %osver%
echo Windows Build: %winbuild%
echo System Architecture: %arch%bit
echo.
echo testmode=%testmode%
echo debug=%debug%
echo debuginstall=%debuginstall%
echo.
echo author=%author%
echo website=%website%
echo projectname=%projectname%
echo detailedprojectname=%detailedprojectname%
echo localversion=%localversion%
echo localversioncheck=%localversioncheck%
echo remoteversion=%remoteversion%
echo remoteversioncheck=%remoteversioncheck%
echo releasedate=%releasedate%
echo releasetime=%releasetime%
echo timezone=%timezone%
echo.
echo versioncheck=%versioncheck%
echo autoupdate=%autoupdate%
echo vcredistdownload=%vcredistdownload%
echo keepcache=%keepcache%
echo disablerestart=%autorestart%
echo autorestart=%autorestart%
echo.
echo scripturl=%scripturl%
echo updateurl=%updateurl%
echo versionurl=%versionurl%
echo vcredisturl=%vcredisturl%
echo archiver64url=%archiver64url%
echo archiver32url=%archiver32url%
echo archiverurl=%archiverurl%
echo.
echo wget=%wget%
echo archiver=%archiver%
echo.
echo bindir=%bindir%
echo vcredistdir=%vcredistdir%
echo.
goto :eof