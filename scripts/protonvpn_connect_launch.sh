#!/bin/sh

((count = 60))                           # Maximum number to try.
while [[ $count -ne 0 ]] ; do
    ping -c 1 8.8.8.8                    # Try once.
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))                    # If okay, flag loop exit.
    else
        sleep 1                          # Minimise network storm.
    fi
    ((count = count - 1))                # So we don't go forever.
done

if [[ $rc -eq 0 ]] ; then                # Make final determination.
    protonvpn-cli c -f
    protonvpn &
fi
