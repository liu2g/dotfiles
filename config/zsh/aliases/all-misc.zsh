# Various alias for different kinds of stuff

alias ls='exa --group-directories-first --icons' # colored ls
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
alias movebook='rsync -auh ~/Downloads/* ~/SSD/Books_new --remove-source-files; find ~/Downloads -type d -empty -delete'
alias logdeck="ssh deck@192.168.0.189 -p 296"
if (! command -v bat &> /dev/null); then alias bat='batcat'; fi
if (! command -v octave &> /dev/null); then alias octave='flatpak run org.octave.Octave'; fi
if (! command -v code &> /dev/null); then alias code='flatpak run com.visualstudio.code'; fi

condaex () {
	# Extract installed pip packages
	pip_packages=$(conda env export | grep -A9999 ".*- pip:" | grep -v "^prefix: ")

	# Export conda environment without builds, and append pip packages
	conda env export --from-history | grep -v "^prefix: "
	echo "$pip_packages"
}


h2 () {
	howdoi $* -c -n 3| less --raw-control-chars --quit-if-one-screen --no-init
	return 0
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

function chpwd() {ls}

