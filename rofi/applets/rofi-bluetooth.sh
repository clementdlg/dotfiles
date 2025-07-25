#!/usr/bin/env bash
set -x
set -euo pipefail

SCAN_TIMEOUT=2
SCAN_FLAG=false

theme="$HOME/.config/rofi/theme/main.rasi"
device_list=()
mac_list=()
state_list=()

rofi_cmd() {
	local msg="$1"
	[[ -z "$msg" ]] && msg="Main menu"
	rofi show -dmenu -i -p "Bluetooth Applet" -theme "${theme}" -mesg "$msg"
}

is_installed() {
	[[ -z "$1" ]] && return 1

	if ! which "$1" &>/dev/null; then
		echo "error : $1 is not installed"
		return 1
	fi
	return 0
}

notify() {
	local message="$1"
	[[ -z "$message" ]] && return

	icon="/usr/share/icons/Papirus/64x64/devices/bluetooth.svg"
	notify-send -i "$icon" "Bluetooth Applet" "$message"
}

silent() {
	"$@" &>/dev/null
}

# 	silent bluetoothctl disconnect "$mac"

# 	silent bluetoothctl remove "$mac"

# 	silent bluetoothctl -t $SCAN_TIMEOUT scan on
# }

# 	bluetoothctl connect "$mac"

device_to_index() {
	local dev_name="$(device_basename "$1")"
	
	for i in "${!device_list[@]}"; do
		local device_basename_i="$(device_basename "${device_list[$i]}")"

		if [[ "$device_basename_i" == "$dev_name" ]]; then
			echo "$i"
			return
		fi
	done
	echo "-1"
}

# remove status from device string
device_basename() {
	local dev="$1"

	if [[ "${dev:0:1}" == " " ]]; then
		echo "${dev:3}"
	else
		echo "$dev"
	fi
}

scan_devices() {
	bluetoothctl -t 8 scan on &
	sleep 8 
	get_devices "all"

	# for i in {1..4}; do 
	# 	sleep 2
	# 	get_devices "all"
	# done
	# echo "log: scan : $SCAN_FLAG"
}

device_menu() {
	local choice="$1"
	local dev_name="$(device_basename "$choice")"
	local index="$(device_to_index "$dev_name")"

	local connect_false=" Connect device"
	local pairing_false=" Pair device"
	local connect_true=" Disconnect device"
	local pairing_true=" Remove device"
	local connection_status="$connect_false"
	local pairing_status="$pairing_false"

	if [[ "${state_list[$index]}" == *"connected"* ]]; then
			connection_status="$connect_true" ;
	fi

	if [[ "${state_list[$index]}" == *"paired"* ]]; then
			pairing_status="$pairing_true" ;
	fi

	local menu="$connection_status\n$pairing_status\n"
	local choice=$(printf "$menu" | rofi_cmd "" )
	
	case "$choice" in
		"$connect_false")
			bluetoothctl pair "${mac_list[$index]}"
			bluetoothctl connect "${mac_list[$index]}" 
			;;
		"$connect_true")
			bluetoothctl disconnect "${mac_list[$index]}" ;;
		"$pairing_false")
			bluetoothctl pair "${mac_list[$index]}" ;;
		"$pairing_true")
			bluetoothctl remove "${mac_list[$index]}" ;;
	esac
}

get_devices() {
	local dev_type="$1"
	local keyword=""
	local icon=""

	case "$dev_type" in
		"paired") 
			keyword="Paired"
			icon=""
			;;
		"connected") 
			keyword="Connected"
			icon=""
			;;
		"all")
			icon=">" ;;
		*)
			return 1
	esac

	local regex="[0-9A-F]{2}(-[0-9A-F]{2}){5}"
	local devices_raw="$(bluetoothctl devices ${keyword} | grep Device | grep -vE "$regex")"

	[[ -z "$devices_raw" ]] && return

	while IFS= read -r line; do
		line_clean="${line//"Device "/}"
		dev_mac="$(echo "$line_clean" | cut '-d ' -f1)"	
		dev_name="${line_clean//"$dev_mac "/}"

		echo "log: line = $line_clean"

		local index="$(device_to_index "$dev_name")"
		if (( index == -1 )); then
			device_list+=(" $icon $dev_name")
			mac_list+=("$dev_mac")
			state_list+=("$dev_type")
		else
			state_list[$index]="${state_list[$index]}:$dev_type"
		fi

	done <<< "$devices_raw"
}

menu_enabled() {
	
	#   Scan Devices
	# Device_name1 |  |  | 󰜴
	# Device_name2 |  | 󰢤 | 󰜴
	# Device_name3 | 󰢤 | 󰢤 | 󰜴
	#   Disable Bluetooth

	local scan=" Scan Devices"
	local disable=" Disable Bluetooth"

	get_devices "connected"
	get_devices "paired"
	
	all_dev="$(printf '%s\n' "${device_list[@]}")"

	local menu="$scan\n$all_dev\n$disable\n$exit\n"
	local choice=$(printf "$menu" | rofi_cmd "" )

	# show device menu dynamically
	if printf '%s\n' "${device_list[@]}" | grep -Fxq "$choice"; then
		device_menu "$choice"
		return
	fi
	
	# static buttons
	case "$choice" in
		$scan)
			scan_devices ;;
		$exit)
			EXIT_FLAG=true
			return
	esac
}

menu_disabled() {
	local enable=" Enable Bluetooth"
	local editor="󰘙 Blueman Manager"
	choice=$(printf "$enable\n$editor\n" | rofi_cmd "" )

	case "$choice" in
		"$enable")
			silent bluetoothctl power on
			notify "Bluetooth has been enabled"
			;;
		"$editor")
			silent blueman-manager & ;;
		$exit)
			EXIT_FLAG=true
			return
	esac
}

main() { 
	is_installed bluetoothctl
	is_installed blueman-manager
	is_installed rofi
	is_installed notify-send

	EXIT_FLAG=false
	exit=" Exit"

	while [[ $EXIT_FLAG == false ]]; do
		if bluetoothctl show | grep "Powered: yes" >/dev/null ; then
			menu_enabled
		else
			menu_disabled
		fi
	done
}

main

# TODO
# add support for trusted devices (trust, untrust)
