#!/bin/bash

FILE_DIR=$(dirname "$(realpath "$0")");

tint2 -c "$FILE_DIR/logout.tint2rc" &>/dev/null &
echo $! > "$HOME/.logoutpid"




