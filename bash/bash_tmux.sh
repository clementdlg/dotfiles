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
		refreshClient

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

function refreshClient() {
	cd() { # each use of 'cd' refreshed the topbar
		builtin cd "$@" && tmux refresh-client -S
	}

	# if zoxide is in use, tmux is refreshed as well
	silent which zoxide
	if [[ $? -eq 0 ]]; then
		z() {
			__zoxide_z "$@" && tmux refresh-client -S
		}
	fi
	unset -f refreshClient # forget the function
}

function setTmuxPrompt() {
	PS1='\[\e[38;5;153;1m\] \[\e[0m\]'
	unset -f setTmuxPrompt # forget the function
}

function tmuxStatus() {
	# format
	local colo="#[bg=#94b6ff]#[fg=#1c1c2e]"
	local s=""
	local e=""

	# git branch
	git -C "$1" rev-parse --is-inside-work-tree &> /dev/null
	if [[ $? -eq 0 ]]; then
		local branch=$(git -C "$1"  rev-parse --abbrev-ref HEAD)
		local git=" $branch"
		local git="$s$git$e"
	fi

	# directory
	local sess=" $2"
	local sess="$s$sess$e"

	# wireguard
	local wga=$(wg show 2>&1)
	local res="$?"
	if [[ -n $wga && $res -ne 127 ]]; then
		local wg="󰞉 wireguard"
		local wg="$s$wg$e"
	fi

	# hostname
	local host="$s󰇄 $(hostname)$e"

	# hostname
	local user="$s $(whoami)$e"

	# output
	echo "$colo$wg$git$user$host$sess"

	unset -f tmuxStatus # forget the function
}

function silent() {
	"$@" &>/dev/null
}

# runner
if [[ -n "$@" ]]; then # their must be at least 1 arg
	if [[ "$1" == "tmuxMain" ]]; then
		tmuxMain
	fi
	if [[ "$1" == "tmuxStatus" && $# -eq 3 ]]; then
		"$@"
	fi
fi
