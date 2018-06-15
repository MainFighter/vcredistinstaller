# In the works
+ Adding the choice to install or not install certain versions
+ Relaunch script after update

# v1.3.2
+ Added a proper unattended mode
+ Fixed issue with restart not showing up at end
+ Spelling mistake

## v1.3.1
+ Fixed problem where it downloaded 2008 x64 instead of 2010 x64
+ Changed 2005 download back to my server because the Microsoft download was causing issues that I can't figure out a way to fix

## v1.3.0
+ You can now choose to download from Microsoft servers (Default option) or Third-Party Servers (Mine by default).
- Downside, will now overwrite the download files everytime instead of only downloading them when a new file is detected. I don't really know a way around this.

###### Changes beta1
Downloads 2005 from Microsoft

## v1.3.0-beta1
+ Now can download from either Microsoft servers or your own servers (default is mine)
+ Options for downloading in variables
+ Added debug screen for download links

## v1.3.0-alpha2
+ Fixed download overwritting

## v1.3.0-alpha1
+ Now downloading from Microsoft servers, besides 2005

## v1.2.9
+ Tweaked what osver outputs
+ WinXP support for restart (script still doesn't fully support windows xp and probably never will)
+ Added test mode for restart
+ Patched pre release version screen
+ Spelling mistakes

## v1.2.8
+ Changed how header is called on new version screen
+ Added header to pre release screen
+ Left debug mode on, I really have to stop doing that
+ Comments added
- Probably gonna be the final version for awhile if nothing goes wrong

## v1.2.7
+ Fixed spelling mistake
+ Request admin screen will now be red
+ Added pre release version screen
+ You can create dontdelete.txt in the same directory the vcredistinstaller.cmd is located in and it won't delete old .bat version
+ Tweaked version check

## v1.2.6
+ Updater should remove old bat files
+ Debug was left enabled again, derp
+ Updater will actually work now, I screwed up.
+ Changed title and added echo in request admin cmd window
- WARNING: It will now remove any file with vcredistinstaller at the beginning and .bat at the end in the folder

## v1.2.5
+ Tweaked debug screen layout
+ Added missing disablerestart
+ Detects Windows version (only used in debug screen)
+ Fixed order of countdown on restart, derp!
+ Tweaked the way restart works slightly

## v1.2.4
+ Changed extension from .bat to .cmd
+ Added option to restart at farewell screen
+ Added auto restart (will just restart without asking)
+ Cleaned up some stuff that wasn't needed in screens
- You can disable restart entirely with disablerestart in config area
- Testing on real x86 system

## v1.2.3
+ For now the updater will update and exit the script, you will have to relaunch it manually
- I am working on a new way to launch the script after update

## v1.2.2
+ Added seperate test and debug mode
+ Changed debug/test mode heavily
- Debug mode will be expanded to show more information on what is happening throughout the script
- Auto updater doesn't actually work on shared drives, I am going to try and fix it but I don't know if it is possible

## v1.2.1 (03/03/2018)
+ Added 7z exe to remove cache
+ Added if exist statement on all instances of removng folders of files
+ Might have left debug mode on again derp
+ Can change warning screen colors
+ Moved the remove cache stuff to after debug
+ Added simulated cache removable to debug
+ Change how debug works slightly

## v1.2.0 (03/03/2018)
+ Overhauled update system
+ Downloads 7z when needed
+ Cleaned up code that was no longer needed

## v1.1.0 (03/03/2018)
+ Added 7z and check for 64 or 32 bit version only really used for auto updater right now
+ Added auto updater
+ Can skip asking whether you want to update or not by setting autoupdate variable at top of file
- There is alot of code that needs to be tweaked, removed and changed

## v1.0.1 (03/03/2018)
+ Changed scripturl to https://mainfighter.com/scripts/vcredistinstaller/release because I changed the file structure on the site

## v1.0.0 (03/03/2018)
+ Release of rewritten script
+ Scipt will check for a new version and warn you if it is out of date
+ Can download the VCRedist files from a remote server
+ The script will detect the architecture of the system and only download and install the needed versions
+ Script can be customised and configured through variables at the top of the file, if you wanna see what you can do open the batch script in an editor the vars are explained there
+ Welcome, farewell, header and footer are being called from the bottom of the file instead of being placed on every needed place
+ There is now a debug mode, not really needed for anything but my personal testing
- The script uses wget to download any files it needs, wget executables are located in bin folder
- 0.x.x is now legacy and no longer supported but should work if you want to use it

###### Changes from RC1
+ Added delay on removing vcredist folder when keepcache is disabled
+ Debug mode was left on true
+ Change the way the out of date screen is displayed
+ Changed what the out of date screen displays slightly
+ Gives you the option to continue or close on update screen
+ Fixed incorrect input on 2005 ask screen
+ Added more comments throughout the script
+ Change detailedname to detailedprojectname
+ Changed the way some of the screens works
+ Added detailedprojectname to top of header
- Am going to comment everything for my own future reference