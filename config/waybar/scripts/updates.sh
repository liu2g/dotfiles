#!/bin/sh

# needs pacman-contrib package from extra repo
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_deb=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade 2> /dev/null | /bin/grep  ^Inst | wc -l); then
    updates_deb=0
fi

if ! updates_flatpak=$(flatpak remote-ls --updates 2> /dev/null | wc -l); then
    updates_flatpak=0
fi


if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
# if ! updates_aur=$(paru -Qum 2> /dev/null | wc -l); then
# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
# if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
# if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
# if ! updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_deb + updates_aur + updates_flatpak))
detail=""

if [ "$updates_arch" -gt 0 ]; then detail="$detail""Pacman: $updates_arch\n"; fi
if [ "$updates_deb" -gt 0 ]; then detail="$detail""Apt: $updates_deb\n"; fi
if [ "$updates_flatpak" -gt 0 ]; then detail="$detail""Flatpak: $updates_flatpak\n"; fi
if [ "$updates_aur" -gt 0 ]; then detail="$detail""AUR: $updates_aur\n"; fi

cat <<EOF
{"text":"$updates", "tooltip":"$detail"}  
EOF
