# Camera & Microphone Control Switches for Linux on Tray

A small utility to switch your webcam on/off, microphone mute/unmute for Linux Desktops (Gtk)

This project replaces the ([camera monitor](https://launchpad.net/cameramonitor)), for having the full webcam status on tray and provides microphone functions aditionally.

Please note that sudo password must be providen, otherwise it will not work.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Background:

- Camera monitor indicates the status of the camera, but it not enough to control the on/off status.
- Microphone mute/unmute status, has no visual indicator and is difficult to remember the switch position in the Volume Icon.
- User can not be all the time in front of the monitor, in order to check the webcam status.
- Such solutions, as below or by plugging in and out the usb cable, are considered funny (not to say rediculous) and unacceptable on any environment (home or business)

    ![Screenshot](https://imgur.com/MmQeg2Y.png)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Solution:

- Provide an additional, or standalone, webcam & microphone switch which loads and unloads the uvc driver, in order to be on the safe side, as much as possible.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Screenshots (Leftside of images is the Camera Monitor tray icon / Right side is the Camera Control tray icon) :

- Camera on, Microphone Unmuted:

    ![Screenshot](https://imgur.com/5nRqTUQ.png)    

- Switch Camera to Off:
    
    ![Screenshot](https://imgur.com/JfVuGQY.png)  

- Switch Microphone to Mute:
    
    ![Schreenshot](https://imgur.com/arNUBSa.png)

- Camera Off, Microphone Muted:

    ![Screenshot](https://imgur.com/tZxSLUD.png)

- Sudo password input, normally entered once per application session, or if Password Reset has been executed:
    
    ![Screenshot](https://imgur.com/kJgWbmI.png)    

- About: 

    ![Screenshot](https://imgur.com/la3h6Sw.png)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Project History
- Created at 23th of January 2020, from scratch with Free Pascal
- Redesigned and further Developed at 28th of January 2020, in order to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions     

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Why on Free (Object) Pascal:

[Main reasons](https://dubst3pp4.github.io/post/2017-10-03-why-i-use-object-pascal/)
