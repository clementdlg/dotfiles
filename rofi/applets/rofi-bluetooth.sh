#!/usr/bin/env bash
set -x
set -euo pipefail

SCAN_TIMEOUT=4

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
		if [[ "${device_list[$i]}" == "$dev_name" ]]; then
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

device_menu() {

	local choice="$1"
	local dev_name="$(device_basename "$choice")"
	local connection_status=""
	local pairing_status=""

	# local menu="$connection_status\n$pairing_status\n"
	local index="$(device_to_index "$dev_name")"
	local menu="${state_list[$index]}"
	local choice=$(printf "$menu" | rofi_cmd "" )
}

get_devices() {
	local dev_type="$1"
	local cmd=""
	local icon=""

	case "$dev_type" in
		"paired") 
			cmd="bluetoothctl devices Paired"
			icon=""
			;;
		"connected") 
			cmd="bluetoothctl devices Connected"
			icon=""
			;;
		*)
			return 1
	esac

	local devices_raw="$($cmd | grep Device)"

	while IFS= read -r line; do
		line_clean="${line//"Device "/}"
		dev_mac="$(echo "$line_clean" | cut '-d ' -f1)"	
		dev_name="${line_clean//"$dev_mac "/}"

		if ! printf '%s\n' "${mac_list[@]}" | grep -Fxq "$dev_mac"; then
			device_list+=("$icon | $dev_name")
			mac_list+=("$dev_mac")
			state_list+=("$dev_type")

			echo "state_list= ${state_list[@]}" # debug
		fi

		local index="$(device_to_index "$dev_name")"
		echo "i= $index" # debug


		if (( index == -1 )); then
			return 1
		fi

		echo "pre: ${state_list[$index]}"
		state_list[$index]="${state_list[$index]}:$dev_type"
		echo "post: ${state_list[$index]}"

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

	local menu="$scan\n$all_dev\n$disable\n"
	local choice=$(printf "$menu" | rofi_cmd "" )

	if printf '%s\n' "${device_list[@]}" | grep -Fxq "$choice"; then
		device_menu "$choice"
	fi
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
	esac
}

main() { 
	is_installed bluetoothctl
	is_installed blueman-manager
	is_installed rofi
	is_installed notify-send

	if bluetoothctl show | grep "Powered: yes" >/dev/null ; then
		menu_enabled
	else
		menu_disabled
	fi
}

main

# mockup device menu 1 :

# Device_name
#  connect
#   trust
#   pair

# mockup device menu 2 :

# Device_name
#  Disconnect
#    Untrust
#   Unpair
