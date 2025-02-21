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
	sessionCount=$(noerr tmux list-sessions | wc -l)

	# getCurrentSession
	current=$(getUnattachedSession)

	if [[ ! -z "$current" ]]; then
		# echo "debug : CURRENT = '$current'"
		noerr tmux attach-session -t "$current"
		return 0
	fi

	if [[ "$sessionCount" -lt "$TMUX_MAX_SESSION" ]]; then
		lastAttached=$(noerr tmux list-clients | tail -1 | awk '{ print $2 }')
		lastDir=$(noerr tmux display-message -t "$lastAttached" -p '#{pane_current_path}')
		noerr tmux new-session -c "$lastDir"
		return 0
	else
		# echo "debug: max number of session created"
		return
	fi

	return 0
}

function getUnattachedSession() {
	noerr tmux list-sessions | while IFS= read -r line; do
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
noerr() { "$@" 2>/dev/null ;}

tmuxMain
# forget the functions
unset -f tmuxMain
unset -f openSession
unset -f silent
unset -f getCurrentSession

