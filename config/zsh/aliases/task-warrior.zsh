# Aliases for Task Warrior

alias tnext='task next'
alias tadd='task add'
alias tmodify='task modify'
alias tedit='task modify'

tdone () {
	task $1 done
	task next
	return 0
}