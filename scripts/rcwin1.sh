 #!/bin/bash
 # Script to start remote control win10 laptop on screen 1
 
xfreerdp /u:Liu /p:221106 /w:2560 /h:1387 /v:192.168.1.4 /t:"RCWin10 on Screen 1" +clipboard +fonts -wallpaper /gdi:hw /sound:sys:pulse
