# Camera & Microphone Control Switches for Linux on Tray

A small utility to switch your webcam on/off, microphone mute/unmute for Linux Desktops (Gtk2, Qt5, [Gtk3 maybe in the future](https://gitlab.com/psposito/camera-control-webcam-switch-indicator/issues/4))

This project replaces the ([camera monitor](https://launchpad.net/cameramonitor)), for having the full webcam status on tray and provides for both camera and microphone switch functions aditionally.

#### Please note that sudo password must be providen, otherwise it will not work. 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Screenshots: 
### (Leftside of images is the System Blacklist/Whitelist added functions, Camera / Microphone Shield status tray icon, Microphone Staus Icon and the last is the Camera Control tray icon):

- Microphone Unmuted, Camera On:

    ![Screenshot](https://imgur.com/LR9EsOP.png)

- Switch Camera to Off:
    
    ![Screenshot](https://imgur.com/mzLaFmi.png) 

- Camera is Off for the User and Applications using the Webcam driver, are stopped-frozen (Not killed yet, still searching the way(?), if achieved) [#5](https://gitlab.com/psposito/camera-control-webcam-switch-indicator/issues/5):

    ![Screenshot](https://imgur.com/f18C2WU.png)
    
    [![](http://img.youtube.com/vi/ncFUDIMkdpw/0.jpg)](http://www.youtube.com/watch?v=ncFUDIMkdpw "Issue #5")
    
    [YouTube link](https://youtu.be/ncFUDIMkdpw)

- Switch Microphone to Mute:
    
    ![Screenshot](https://imgur.com/X59w7Qq.png)

- Camera Off, Microphone Muted:

    ![Screenshot](https://imgur.com/Edhnlmr.png)

- Sudo password input, normally entered once per application session, or if Password Reset has been executed:
    
    ![Screenshot](https://imgur.com/kJgWbmI.png)   

- Shield event (for both microphone and camera):
    
    ![Screenshot](https://imgur.com/wbHBcjG.png)

- Shield event status (Microphone was hacked, switched status to Unmuted):

    ![Screenshot](https://imgur.com/YGnCAdy.png)
    
- Events Log menu:
    
    ![Screenshot](https://imgur.com/K4O5yaY.png)

- External Events (hacked) Log List:
    
    ![Screenshot](https://imgur.com/5f5K4d8.png)

- Logs cleared, Shield Status Icon, changed:

    ![Screenshot](https://imgur.com/yAnk8Mw.png)

- System Menu (Blaclist/Whitelist Camera and/or Microphone), About and Exit functions: 

    ![Screenshot](https://imgur.com/4kG1dCN.png)
    
- Reboot Window: 

    ![Sreenshot](https://imgur.com/eGKNVKC.png)
    
- ### Note that before reboot, all Blacklist/Whitelist functions are being reverted (Undone), if Cancel button is pressed.

- About: 

    ![Screenshot](https://imgur.com/JQbK2EP.png)
    
    (click on the links to open)

# Video Demos: 

### (click the links below them, or click and open the [Youtube Playlist](https://www.youtube.com/playlist?list=PLAG2B-41QEHVhg2O8flo-gUIE1Mfg8iRt))

##   Camera Control Final Release Qt5, [1.2](https://gitlab.com/psposito/camera-control-webcam-switch-indicator/-/tags/1.2) Release.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-   [![](http://img.youtube.com/vi/iqOZ8A2S-zg/0.jpg)](http://www.youtube.com/watch?v=iqOZ8A2S-zg "CameraControl-1.2")

-   ### https://youtu.be/iqOZ8A2S-zg

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Prerequisites 

#### For Desktops not based on Gtk, but on Qt i.e. KDE, LxQt etc, it may be neccessary to be installed, for proper appearance of icons, menus e.t.c., the following package: 

- ##### `qt5pas` (Arch, AUR), 
- ##### `libqt5pas-dev`, `libqt5pas1` (Debian/Ubuntu),
- ##### `libQt5Pas-devel`, `libQt5Pas` from [ecsos](http://download.opensuse.org/repositories/home:/ecsos/) repository, (OpenSuse Leap / Tumbleweed)

#### For Desktops not based on Qt, but on GTK i.e. Gnome, LxDE, XFCE etc, it may be neccessary to be installed, for proper appearance of icons, menus e.t.c., the following packages: 

- ##### `qt5ct` (All Distributions)
- ##### `qt5-style-plugins` (All Distributions, but OpenSuse)
- ##### `libqt5-qtstyleplugins-platformtheme-gtk2` (OpenSuSe) 


#### Select the name(s) from the above list, by the name of your Distribution (either major or derived from), respectively.

# Further Details at the [Wiki](https://gitlab.com/psposito/camera-control-webcam-switch-indicator/-/wikis/Project-History-and-other-Details)