# Camera & Microphone Control Switches for Linux on Tray

A small utility to switch your webcam on/off, microphone mute/unmute for Linux Desktops (Gtk2, Gtk3 in the future)

This project replaces the ([camera monitor](https://launchpad.net/cameramonitor)), for having the full webcam status on tray and provides for both camera and microphone switch functions aditionally.

#### Please note that sudo password must be providen, otherwise it will not work. 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Background:

- Camera monitor indicates the status of the camera, but it not enough to control the on/off status.
- Microphone mute/unmute status, has no visual indicator and is difficult to remember the switch position in the Volume Icon.
- User can not be all the time in front of the monitor, in order to check the webcam status.
- Such solutions, as below or by plugging in and out the usb cable, are considered funny (not to say rediculous) and unacceptable on any environment (home or business)

    ![Screenshot](https://imgur.com/MmQeg2Y.png)

- v4l2-ctl does not provide a direct way to switch Camera, either On, or Off 

    ![Screenshot](https://imgur.com/wF4RCu5.png)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Solution:

- Provide an additional, or standalone, webcam & microphone switch which loads and unloads the uvc driver, in order to be on the safe side, as much as possible.

## News - 2nd of Feb, 2020, final Development Stage for Release:

- ### Closed Project's Target Issue [#1](https://gitlab.com/psposito/camera-control-webcam-switch-indicator/issues/1), External Events (hacking) Warnings and Logs, please read it for further details

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Screenshots (Leftside of images is the Camera Monitor tray icon / Right side is the Camera Control tray icon):

- Camera on, Microphone Unmuted:

    ![Screenshot](https://imgur.com/5nRqTUQ.png)    

- Switch Camera to Off:
    
    ![Screenshot](https://imgur.com/JfVuGQY.png)  

- Switch Microphone to Mute:
    
    ![Screenshot](https://imgur.com/arNUBSa.png)

- Camera Off, Microphone Muted:

    ![Screenshot](https://imgur.com/tZxSLUD.png)

- Sudo password input, normally entered once per application session, or if Password Reset has been executed:
    
    ![Screenshot](https://imgur.com/kJgWbmI.png)    

- About: 

    ![Screenshot](https://imgur.com/XB9hrBY.png)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Project History

- Created at 23th of January 2020, from scratch with Free Pascal, please ref. to the below, why
- Redesigned and further Developed at 28th of January 2020, in order to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions   
- Added feeling of Malware or unwanted functions, i.e. if Camera switches On, when is Off, the tray icon will change state accordingly. Tha same is valid for the microphone mute/unmute

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# [Why on Free (Object) Pascal](https://dubst3pp4.github.io/post/2017-10-03-why-i-use-object-pascal/) and not Python3 or any other?

## Some of the main reasons are:

- Easier code maintenance, really important in the long term

- Nice memory footprint... 29.4 MB with much more Graphical User Interface (two icon trays, one About Form and one Main Form), versus 23.2 MB of Camera Monitor Python3 (one trayicon, no Graphical User Interface). For Desktop PCs is not a big deal, but Linux does not run only on Desktops PCs.

    ![Screenshot](https://imgur.com/A7rIahz.png)
    
- Faster startup, menus, etc. 
- Robust tested Programming Language, over 30 years of Development
- Nice Gui touch (Contemporary Looking Components)
- Very big support community, fast responding
- Others

## GitLab bug, shows PKGBUILD as Visual Basic part, which is incorrect

-   ![Screenshot](https://imgur.com/hb9FcKJ.png)
    
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Video Demo (click on it, or click on the link below, to open the Youtube page)

-   [![Camera Control](http://img.youtube.com/vi/pUuoOgVzXNU/0.jpg)](http://www.youtube.com/watch?v=pUuoOgVzXNU "Camera Control Video")

### https://youtu.be/pUuoOgVzXNU

# Notes

#### For Desktops not based on Gtk, but on Qt i.e. KDE, LxQt etc, it is neccessary to be installed, for proper appearance of icons, menus e.t.c., the following package: 

- ##### qt5gtk2 (Arch), 
- ##### qt5-gtk-platformtheme (Debian/Ubuntu),
- ##### libqt5-qtstyleplugins-platformtheme-gtk2 (OpenSuSe) 

#### Select the name from the above list, by the name of your Distribution (either major or derived from), accordingly.