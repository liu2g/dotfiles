 #!/bin/bash
 # Script to start remote control Windows10 laptop on screen 2
 
xfreerdp /u:Liu /p:221106 /w:1080 /h:1872 /v:192.168.1.4 /t:"RCWin10 on Screen 2" +clipboard +fonts -wallpaper /gdi:hw /sound:sys:pulse
