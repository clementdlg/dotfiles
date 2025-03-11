#!/usr/bin/env bash
set -xeuo pipefail

SCAN_TIMEOUT=4

theme="$HOME/.config/rofi/theme/main.rasi"

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

choose_device() {
	local type="$1"
	if ! echo "$type" | grep -E "Connected|Paired"; then
		type=""
	fi
	
	local message="$2"
	[[ -z "$message" ]] && return 1

	local devices="$(bluetoothctl devices $type | awk '{$1=$2=""; print substr($0,3)}')"

	# printf "%s\n" "$devices" # debug

	device="$(printf "%s\n" "$devices" | rofi_cmd "$message")"

	echo "$device"
}

get_mac_addr() {
	device="$1"
	[[ -z "$device" ]] && return 1

	bluetoothctl devices | grep "$device" | cut -f2 -d' '
}

disconnect_device_menu() {
	device="$(choose_device "Connected" "Disconnect a device")"
	mac="$(get_mac_addr "$device")"

	notify "Disconnecting $device"
	silent bluetoothctl disconnect "$mac"
}

rm_devices_menu() {
	device="$(choose_device "Paired" "Remove a device")"
	mac="$(get_mac_addr "$device")"

	notify "Removing $device"
	silent bluetoothctl remove "$mac"
}

get_scanned_device() {
	notify "Scanning for devices..."

	silent bluetoothctl -t $SCAN_TIMEOUT scan on

	device="$(choose_device "" "Connect a device")"

	echo "$device"
}

connect_device() {
	local device="$1"
	[[ -z "$device" ]] && return 1

	mac="$(get_mac_addr "$device")"

	notify "Attempting to connect to $device"
	silent bluetoothctl connect "$mac"
}

menu_enabled() {
	# menu items
	local connect_menu="󰂱 Connected devices 󰜴"
	local paired_menu=" Paired devices 󰜴"
	local scan_menu="󰂰 Scan devices 󰜴"
	local remove_menu=" Remove devices 󰜴"
	local disable=" Disable Bluetooth"
	local editor="󰘙 Blueman Manager"

	# menu
	local menu="$connect_menu\n$paired_menu\n$scan_menu\n$remove_menu\n$disable\n$editor\n"

	local choice=$(printf "$menu" | rofi_cmd "" )

	case "$choice" in
		"$connect_menu")
			disconnect_device_menu
			;;
		"$paired_menu")
			device="$(choose_device "Paired" "Connect a device")"
			connect_device "$device"
			;;
		"$scan_menu")
			device="$(get_scanned_device)"
			connect_device "$device"
			;;
		"$remove_menu")
			rm_devices_menu
			;;
		"$disable")
			silent bluetoothctl power off
			notify "Bluetooth has been disabled"
			;;
		"$editor")
			silent blueman-manager & ;;
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
	esac
}

main() { 
	is_installed bluetoothctl
	is_installed blueman-manager
	is_installed rofi
	is_installed notify-send

	if bluetoothctl show | grep -q "Powered: yes"; then
		menu_enabled
	else
		menu_disabled
	fi
}
main
