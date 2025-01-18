#!/bin/env bash
# centrazed all the tmux conf

function tmuxMain() {
	# exit if tmux is not installed
	which tmux &>/dev/null
	if [[ $? -ne 0 ]]; then
		return
	fi

	# check if inside of tmux
	if [[ -n $TMUX ]]; then
		# inside of tmux
		setTmuxPrompt
	else
		# not inside of tmux
		openSession
	fi

	unset -f tmuxMain # forget the function
}

function openSession() {
	silent tmux list-sessions
	local session="$?"
	local clients=$(tmux list-clients)

	if [[ $session -eq 0 ]]; then # if their is a session
		if [[ -z $clients ]]; then # but no clients attached
			silent tmux attach
		fi
	else
		silent tmux new-session # this is no session
	fi
	unset -f openSession # forget the function
}

function setTmuxPrompt() {
	PS1='\[\e[38;5;153;1m\] \[\e[0m\]'
	unset -f setTmuxPrompt # forget the function
}

function silent() {
	"$@" &>/dev/null
}

tmuxMain
