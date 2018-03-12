# v1.0.0rc1 (03/03/2018)
+ Cleaned up and fixed spelling errors
+ Added more comments on what some of the stuff does
+ Changed the way debug and disabling parts works
+ Added test for 2005 install in debug
+ Revamped debug screen
+ Added projectname and detailedname as variables
- The comments might be moved to a readme later instead
- Basically done, just doing cleanup and bug testing
- Tested on Windows 7 x64 and Windows 10 x64 Insider build 17110 both on share and local drive
- Haven't tetsing on actual x86 system yet

## v1.0.0beta2
+ Readded ability to not install 2005
+ Cleaned up script and echos
+ Added ability to remove downloaded files on end of script
+ Added ability to disable downloading vcredist files
+ Added ability to disable version check
+ Added more customisation
+ Fixed the removing of administrator evelate script
+ Added local and remote versions to check version screen

## v1.0.0beta1
+ Tested and fixed any issues with running on share
+ Added farewell screen
+ Disabled debug, was left on in alpha2
+ Downloader debug was using off instead of false

## v1.0.0alpha2 (02/03/2018)
+ Now only downloads the VC++ Redists that are needed for the architecture
+ Added some customisation
+ Moved the header and welcome screen to bottom of script and are now called from there
+ Added debug mode, mostly only for personal testing
+ Added title can be changed at top of script
+ Moved getting admin rights to top fo script
+ Cleaned up some stuff
- Still not tested on share
- Still can't select to not install VC 2005
- Version check not implemented yet

## v1.0.0alpha1 (02/03/2018)
+ Completely rewritten
+ Detects system architecture (64bit or 32bit)
+ Downloads Visual C++ Redists from remote server using wget, can be changed to use your own server
+ Only trys to install the VC redist that works on the architecture
+ Includes wget for 32bit and 64bit and uses the one that is correct
- Can no longer select not to install VC 2005 (going to be readded)
- Not tested on share
- Needs alot of testing and tweaking
- Downloads a version.txt file from server but version check not yet implemented