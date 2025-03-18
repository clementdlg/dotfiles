#!/usr/bin/env bash

# Description : This script starts a VM using virsh cli utility
# Author : Clément DE LA GENIERE

set -xeuo pipefail

# error handling
trapcmd="Failed at line $LINENO. Command : $BASH_COMMAND"

# global variables
uri="qemu:///system"

start="> Start VM"
open="> Open VM's console"
shutdown="! Shutdown VM"
reboot="! Reboot VM"

theme="$HOME/.config/rofi/theme/main.rasi"

# Utils

isInstalled() {
	if [[ -z "$1" ]]; then
		return 1
	fi

	if ! which "$1" &>/dev/null; then
		echo "VM Applet error : $1 is not installed"
		return 1
	fi
}

silent() {
	"$@" &>/dev/null
}

rofi_cmd() {
	rofi show -dmenu -i -p "VM Applet" -theme "${theme}"
}


# VM Actions
start-vm() {
	local vm="$1"
	silent virsh start --domain "$vm"
	notify-send "VM Applet" "$vm has been started"
}

open-vm() {
	local vm="$1"
	silent virt-manager -c "$uri" --show-domain-console "$vm" &
}

stop-vm() {
	local vm="$1"
	silent virsh destroy --domain "$vm" --graceful
	notify-send "VM Applet" "$vm has been stopped"
}

reboot-vm() {
	local vm="$1"
	silent virsh reset --domain "$vm"
	notify-send "VM Applet" "$vm has been rebooted"
}


# Core functions
choose-vm() {
	local vms="$(virsh list --all  | tail -n +3 | head -n -1 | awk '{ print $2 }')"

	# display VMs list
	local choice="$(printf "%s\n" "$vms" | rofi_cmd)"

	# verifs
	if [[ -z "$choice" ]]; then
		notify-send "VM Applet info" "Empty choice"
		return 1
	fi

	if ! silent virsh dominfo --domain "$choice"; then
		notify-send "VM Applet error" "the selected vm does not exist"
		return 1
	fi

	echo "$choice"
}

get-vm-state() {
	vm="$1"
	[[ -z "$vm" ]] && return 1
	virsh domstate "$vm"
}

main() {
	trap "notify-send $trapcmd" ERR
	isInstalled virsh || return 1
	isInstalled notify-send || return 1
	isInstalled rofi || return 1
	isInstalled virt-viewer || return 1

	local vm="$(choose-vm)"
	[[ -z "$vm" ]] && return 1

	local state="$(get-vm-state "$vm")"
	local menu=""

	# setting menu according to VM state
	case "$state" in
		"running")
			# menu for running vm
			menu="$open\n$shutdown\n$reboot\n"
			;;
		"shut off")
			# menu for shutoff vm
			menu="$open\n$start\n"
			;;
	esac

	# user choose an action
	local action="$(printf "$menu" | rofi_cmd)"
	[[ -z "$action" ]] && return 1
	echo "action= $action"

	case "$action" in
		"$open")
			open-vm "$vm"
			;;
		"$start")
			start-vm "$vm"
			open-vm "$vm"
			;;
		"$shutdown")
			stop-vm "$vm"
			;;
		"$reboot")
			reboot-vm "$vm"
			;;
	esac
}

main
