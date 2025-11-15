#!/usr/bin/env bash

# monitor = name, resolution, position, scale

set_mirror() {
	hyprctl keyword monitor ${builtin_conf}, mirror, $_EXTERNAL_NAME

}

get_external_monitor_name() {
	local external_name="${_MONITOR_TABLE[0]}"

	if [[ "${_MONITOR_TABLE[0]}" == "eDP-1" ]]; then
		external_name="${_MONITOR_TABLE[1]}"
	fi

	_EXTERNAL_NAME="$external_name"
}

main() {
	buildin_name="Chimei Innolux Corporation 0x1529"
	builtin_conf="desc:${buildin_name}, highres@highrr, auto-down, 1"

	_MONITOR_TABLE=($(hyprctl monitors -j | jq -r '.[].name'))
	monitors_count="${#_MONITOR_TABLE[@]}"

	if (( monitors_count == 2 )); then
		echo "2 monitors detected"
		get_external_monitor_name 
		set_mirror 
	else 
		echo "count = $monitors_count"
	fi
}

main "$@"
