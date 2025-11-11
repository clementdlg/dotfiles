#!/usr/bin/env bash

rofi_cmd() {
	rofi show -dmenu -i -p "$uptime" -theme "${theme}"
}

main() {
	theme="$HOME/.config/rofi/theme/main.rasi"
	local lockscreen=" Lock Screen"
	local logoff=" Log Out"
	local shutdown=" Power Off"
	local restart=" Restart"
	local uptime="$(uptime -p | sed -e 's/up /Uptime: /g')"

	local menu="$lockscreen\n$logoff\n$shutdown\n$restart\n"
	choice="$(printf "$menu" | rofi_cmd )"

	case "$choice" in
		"$lockscreen")
			hyprlock ;;
		"$logoff")
			loginctl kill-session $XDG_SESSION_ID ;;
		"$shutdown")
			systemctl poweroff ;;
		"$restart")
			systemctl reboot ;;
	esac
}

main
