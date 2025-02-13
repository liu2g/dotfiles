function movebook
    find $HOME/Downloads/ -depth -type d -regex '.* ' -exec sh -c 'mv -v "$1" "$(echo "$1" | sed "s/ *$//")"' -- {} \;
    rsync -auh ~/Downloads/* ~/HDD/Books_new --remove-source-files --prune-empty-dirs
    find ~/Downloads -type d -empty -delete
end
