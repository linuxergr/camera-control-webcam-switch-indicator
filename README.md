# Camera Control Webcam Switch Indicator

A small utility to switch your webcam on/off for Linux Desktops (Gtk)

This project is an addition to ([camera monitor](https://launchpad.net/cameramonitor)), for having the full webcam status on tray.

Please note that sudo password must be providen, otherwise it will not work.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Background:

- Camera monitor indicates the status of the camera, but it not enough to control the on/off status.
- User cann not be all the time in front of the monitor, in order to check the webcam status.
- Such solutions, as below, or plug in and out the usb cable, are considered unacceptable on any environment (home or business)

    ![Screenshot](https://imgur.com/MmQeg2Y.png)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Solution:

- Provide an additional, or standalone, webcam switch which loads and unloads the uvc driver, in order to be on the safe side, as much as possible.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Screenshots (Leftside of images is the Camera Monitor tray icon / Right side is the Camera Control tray icon) :

- Webcam is on:

    ![Screenshot](https://imgur.com/x00sDWC.png)    

- Switch webcam to off:
    
    ![Screenshot](https://imgur.com/CQSlHe9.png)    

- Sudo password input / once per session:
    
    ![Screenshot](https://imgur.com/T7eUqHJ.png)    

- Camera is off:
    
    ![Screenshot](https://imgur.com/nP3z07M.png)    

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

