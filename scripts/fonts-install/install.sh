#!/bin/sh

cp fonts/** $HOME/.local/share/fonts/ -f
fc-cache -f -v
