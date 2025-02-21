#!/bin/env bash
# tmux environment conf

TMUX_MAX_SESSION=3

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
	sessionCount=$(tmux list-sessions | wc -l)

	# echo "session $sessionCount"
	# if [[ "$sessionCount" -lt 1 || "$sessionCount" -gt 3 ]]; then
	# 	echo "session count must be from 1 to 3"
	# 	return 0
	# fi

	# getCurrentSession
	current=$(getCurrentSession)

	if [[ -z "$current" ]]; then
		if [[ "$sessionCount" -lt 3 ]]; then
			tmux new-session
			return 0
		else
			echo "debug: max number of session created"
			return
		fi
	fi
	echo "debug : CURRENT = '$current'"
	tmux attach-session -t "$current"

	return 0
}

function getCurrentSession() {
	tmux list-sessions | while IFS= read -r line; do
		# echo "debug : LINE = $line"
		nf=$(printf "%s" "$line" | awk '{ print $NF }' 2>/dev/null)
		# echo "debug : NF = '$nf'"
		if [[ "$nf" != "(attached)" ]]; then
			current=$(echo "$line" | cut -d: -f1)
			echo "$current"
			break
		fi
	done
	return 0
}

silent() { "$@" &>/dev/null ;}

tmuxMain
# forget the functions
unset -f tmuxMain
unset -f openSession
unset -f silent
