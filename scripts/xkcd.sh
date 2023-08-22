#!/usr/bin/env bash

# https://www.roboleary.net/2022/02/24/xkcd-in-the-terminal-with-some-bash-magic.html
# Dependency: kitty terminal

URL=https://c.xkcd.com/random/comic

img=$(curl -s -L $URL | 
grep 'href= "https://imgs.xkcd.com/comics.*' | 
cut -d'>' -f2 | 
cut -d'<' -f1)

kitty +kitten icat $img

