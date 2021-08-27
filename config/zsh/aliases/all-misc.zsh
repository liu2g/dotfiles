# Various alias for different kinds of stuff

alias ls='exa --group-directories-first --icons' # colored ls
alias erc='vim ~/.config/zsh/'
alias src='source ~/.zshrc'
alias logserver='ssh 192.168.0.137'
alias down2='/bin/ls -datr /home/liu/Downloads/** | tail -n 1 | xargs -I\{\} mv \{\}'
alias latexmk-all='latexmk && latexmk -c'
alias sau="sudo apt update && sudo apt upgrade"
alias lsa='ls -a'


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

