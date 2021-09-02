#!/bin/sh

cp fonts/** $HOME/.local/share/fonts/ -f
sudo fc-cache -f -v
