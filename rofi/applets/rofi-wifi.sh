#!/usr/bin/env bash
set -xueo pipefail

theme="theme/main.rasi"

rofi_cmd() {
	msg="Menu"
	[[ ! -e "$1" ]] && msg="$1"
	rofi show -dmenu -p "Wi-Fi Applet" -theme "${theme}" -mesg "$msg"
}

function is_installed() {
	[[ -z "$1" ]] && return 1

	if ! which "$1" &>/dev/null; then
		echo "error : $1 is not installed"
		return 1
	fi
	return 0
}

notify() {
	message="$1"
	[[ -z "$message" ]] && return

	icon="/usr/share/icons/Papirus/64x64/devices/network-wireless.svg"
	notify-send -i "$icon" "Wifi Applet" "$message"
}

silent() {
	"$@" &>/dev/null
}

get_wifi_list() {
	local wifi_list="$(nmcli -t -f "SIGNAL,SSID" device wifi list)"

	printf "%s\n" "$wifi_list" \
		| grep -v ":$" \
		| head -15 \
		| awk -F: '{ \
		if ($1 >= 0 && $1 < 25) $1 = "󰤯 "; \
		else if ($1 >= 25 && $1 < 50) $1 = "󰤟 "; \
		else if ($1 >= 50 && $1 < 75) $1 = "󰤢 "; \
		else if ($1 >= 75 && $1 <= 100) $1 = "󰤨 "; \
		print}'
}

connect() {
	notify "Scanning Wi-Fi networks..."

	list=$(get_wifi_list)

	choice=$(echo -e "$list" | uniq | rofi_cmd "Wi-Fi Connection:" )
	echo "choice = $choice"

	read -r choice_clean <<< "${choice:2}"
	
	# check if network is known
	if nmcli -g NAME connection | grep $choice_clean; then
		nmcli connection up id "$choice_clean"
	else
		password=$(echo "" | rofi_cmd "Password:")
		nmcli device wifi connect "$choice_clean" password "$password"
	fi

	notify "Successfully connected to '$choice_clean'"
}

connect_hidden() {
	local ssid=$(echo "" | rofi_cmd "Wi-Fi Name (ssid) :")
	local password=$(echo "" | rofi_cmd "Wi-Fi Name (ssid) :")
	nmcli device wifi connect "$ssid" password "$password"
}

menu_enabled() {
	# check if already connected to a wifi
	local current="$(nmcli -t -f NAME,TYPE connection show --active | grep '802-11' | cut -f1 -d:)"

	# menu items
	local disconnect="󰤭 Disconnect from '$current'"
	local connect=" Connect to Wi-Fi"
	local hidden="󰤨 Connect to hidden Wi-Fi"
	local disable=" Disable Wi-Fi"
	local editor="󰘙 Connection Editor"

	# menu
	local menu="$connect\n$hidden\n$disable\n$editor\n"

	# add disconnect item
	if [[ ! -z "$current" ]]; then
		menu="$disconnect\n$menu"
	fi

	local choice=$(printf "$menu" | rofi_cmd "Menu"  )

	case "$choice" in
		"$disconnect")
			nmcli connection down "$current"
			notify "Disconnected from '$current'"
			;;
		"$connect")
			connect ;;
		"$hidden")
			connect_hidden ;;
		"$disable")
			nmcli radio wifi off
			notify "Wi-Fi has been disabled"
			;;
		"$editor")
			silent nm-connection-editor & ;;
	esac
}

menu_disabled() {
	enable="󰖩 Enable Wi-Fi"
	editor="󰘙 Connection Editor"
	choice=$(printf "$enable\n$editor\n" | rofi_cmd "Menu"  )

	case "$choice" in
		"$enable")
			nmcli radio wifi on
			notify "Wi-Fi has been enabled"
			;;
		"$editor")
			silent nm-connection-editor & ;;
	esac
}

main() {
	is_installed nmcli
	is_installed nm-applet
	is_installed rofi
	is_installed notify-send

	local state=$(nmcli --colors=no radio wifi)

	if [[ "$state" == "enabled" ]]; then
		menu_enabled
	else
		menu_disabled
	fi
}

main
