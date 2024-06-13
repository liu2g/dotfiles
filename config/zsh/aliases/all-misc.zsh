# Various alias for different kinds of stuff

alias ls='eza --group-directories-first --icons' # colored ls
alias erc='vim ~/.config/zsh/'
alias src='source ~/.zshrc'
alias logserver='ssh 192.168.0.137'
alias down2='/bin/ls -datr /home/liu/Downloads/** | tail -n 1 | xargs -I\{\} mv \{\}'
alias latexmk-all='latexmk && latexmk -c'
alias sau="sudo apt update && sudo apt upgrade"
alias lsa='ls -a'
alias nv='nvim'
alias cd="pushd"
alias dirs="dirs -v"
alias logdeck="ssh deck@192.168.0.189 -p 296"
alias wdump="lynx -width 100000 -dump"
if (! command -v bat &> /dev/null); then alias bat='batcat'; fi
if (! command -v octave &> /dev/null); then alias octave='flatpak run org.octave.Octave'; fi
if (! command -v code &> /dev/null); then alias code='flatpak run com.visualstudio.code'; fi
if (! command -v sioyek &> /dev/null); then alias sioyek='flatpak run com.github.ahrm.sioyek'; fi
if (command -v matlab &> /dev/null); then alias matlabsh='matlab -nodesktop'; fi
if (command -v vivado &> /dev/null); then alias vivadosh='. $(realpath $(which vivado)) -mode tcl'; fi
fork() { (setsid "$@" &); }

condaex () {
	# Extract installed pip packages
	pip_packages=$(conda env export | grep -A9999 ".*- pip:" | grep -v "^prefix: ")

	# Export conda environment without builds, and append pip packages
	conda env export --from-history | grep -v "^prefix: "
	echo "$pip_packages"
}

# submit () {
    # # Initialize submit dir
    # mkdir -p submitd
    # for f in "$@"; do
        # ln -sr "$f" submitd/
    # done
    # zipfile="liu_$(basename "$PWD")_submitd.zip"
    # zip -r "$zipfile" submitd/
    # echo "==> ARCHIVED $(zipinfo -1 "$zipfile" | tail -n +2 | wc -l) file(s)"
# }

zipd () {
    zip -r $1 $1
}

# Language related tools
alias tozh='trans :zh'
alias toen='trans :en'

closeto() {
	wn $1 -synsn | grep -v ^$
	echo ""
	wn $1 -synsv | grep -v ^$
	echo ""
	wn $1 -synsa | grep -v ^$
	echo ""
	wn $1 -synsr | grep -v ^$
	return 0
}

lastbook() {
	DIR=$(find $HOME/SSD/Books_new -name $1); [[ ! -z "$DIR" ]] && {date -r "$DIR" "+%F"; /bin/ls -t "$DIR" | head -n 1; thunar "file://$DIR"}
}

movebook() {
    find $HOME/Downloads/ -depth -type d -regex '.* ' -exec sh -c 'mv -v "$1" "$(echo "$1" | sed "s/ *$//")"' -- {} \;
    rsync -auh ~/Downloads/* ~/SSD/Books_new --remove-source-files
    find ~/Downloads -type d -empty -delete
}

function chpwd() {ls}

function set_terminal_title() {
  echo -en "\e]2;$@\a"
}
