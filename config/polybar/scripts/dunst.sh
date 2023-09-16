#!/usr/bin/env bash

is_paused="$(dunstctl is-paused)"
if [[ "$is_paused" == "false" ]]; then
    echo "    "
elif [[ "$is_paused" == "true" ]]; then
    echo "    "
else
    echo "?"
fi
