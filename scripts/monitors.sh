#!/usr/bin/env bash

# set -x

##################"

# mirror #1 on #2
# reset everything

# monitor = name, resolution, position, scale

set_mirror() {
	echo "Mirroring eDP-1 -> $_EXTERNAL_NAME"
	hyprctl keyword monitor ${builtin_conf}, mirror, $_EXTERNAL_NAME

}

reset_builtin() {
	echo "Resetting eDP-1"
	hyprctl keyword monitor $builtin_conf
}

get_external_monitor_name() {
	local external_name="${_MONITOR_TABLE[0]}"

	if [[ "${_MONITOR_TABLE[0]}" == "eDP-1" ]]; then
		external_name="${_MONITOR_TABLE[1]}"
	fi

	_EXTERNAL_NAME="$external_name"
}

search_monitors() {
	set -u
	target_name="$1"
	set +u

	echo "${_MONITOR_TABLE[@]}" | grep -qw "$target_name"
}

main() {
	builtin_name="eDP-1"
	builtin_conf="${builtin_name}, highres@highrr, auto-down, 1"

	_MONITOR_TABLE=($(hyprctl monitors -j | jq -r '.[].name'))
	monitors_count="${#_MONITOR_TABLE[@]}"

	# declare -p _MONITOR_TABLE # debug

	if (( monitors_count == 2 )) && search_monitors "$builtin_name"; then
		get_external_monitor_name 
		set_mirror 
	else 
		# echo "count = $monitors_count" # debug
		reset_builtin 
	fi
}

main "$@"
