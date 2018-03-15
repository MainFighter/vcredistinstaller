# Visual C++ Redistributable Download and Installer script

**The script will download the Visual C++ Redistributables from Microsoft**

*7zip (needed for auto update), version file and auto update files all come from my servers*

*You can use this script for whatever you want, just give me some credit aye* ;)

## What does it do?

The script just downloads (from my servers) and installs Visual C++ Redistributables in the background without the need for user input. The script will automatically elevate it's permissions (still needs users consent) when the script is started.

## How do I use it?

Simply run the vcredistinstaller.cmd script should be self-explanatory from there.

## Customization

The script is pretty customizable through the variables that are placed at the top of the script itself, all the variables are explained inside the script. I set out to make it as customizable as possible and will most likely continue making it more customizable as I continue to add things.

## Background

The script was originally made as a simple background installer script for automated Windows installs, I decided to make the script its own thing because I needed to use it outside of that. I then started adding more stuff to the script because I wanted to see what I could actually do with it, I eventually decided to start over and make it customizable and modular so I could easily use it for other things. Yes, it is overcomplicated for the task it is designed to accomplish but that is because I wanted to see exactly what I could do with batch scripts and I have used it in other tasks besides installing VC++ Redists since I remade the script. The only real reason it was ever uploaded to GitHub was because I wanted to learn how to properly use GitHub and Git.