#!/bin/bash

folder_name=$(yad --entry --entry-label="Enter name" --width=500 --height=100 --entry-text=$(printf $(copyq clipboard)))
if [[ -z "$folder_name" ]]; then
    exit 1
fi
folder_name=$(echo "$folder_name" | xargs) # trim any leading/trailing whitespace
search_dir="$HOME/HDD/Books_new"
found_folder=$(find "$search_dir" -type d -iname "$folder_name" -print -quit)
if [[ -n "$found_folder" ]]; then
    thunar "$search_dir/$folder_name"
else
    notify-send "find-book.sh" "$folder_name  not found" -u critical -i dialog-error
fi

