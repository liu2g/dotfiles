#!/usr/bin/env bash

for i in $(xinput list --id-only); do
    if [ "$(xinput list --name-only $i)" = "SYNA30D2:00 06CB:CE08" ]; then
        if xinput set-prop $i "libinput Click Method Enabled" 0, 1; then
            echo $i
            exit 0
        fi
    fi
done
