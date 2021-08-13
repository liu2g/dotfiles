#!/bin/bash
export DISPLAY=:0
/usr/bin/gcalcli remind --use_reminders 10 "kdialog --title='Calendar Reminder' --msgbox %s"

