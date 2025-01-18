#!/bin/env bash
# tmux environment conf

function tmuxMain() {
	# exit if tmux is not installed
	silent which tmux || return

	# check if inside of tmux
	if [[ -n $TMUX ]]; then
		PS1='\[\e[38;5;153;1m\] \[\e[0m\]' # inside of tmux
	else
		openSession # not inside of tmux
	fi
}

function openSession() {
	if silent tmux list-sessions; then # if their is a session
		if [[ -z "$(tmux list-clients)" ]]; then # but no clients attached
			silent tmux attach
		fi
		return
	fi
	silent tmux new-session # this is no session
}

silent() { "$@" &>/dev/null ;}

tmuxMain
# forget the functions
unset -f tmuxMain
unset -f openSession
unset -f silent
