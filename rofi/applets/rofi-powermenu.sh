#!/usr/bin/env bash

rofi_cmd() {
	rofi show -dmenu -p "Power Menu" -theme "${theme}" -mesg "$uptime"
}

main() {
	theme="theme/main.rasi"
	local lockscreen=" Lock Screen"
	local logoff=" Log Out"
	local shutdown=" Power Off"
	local restart=" Restart"
	local uptime="$(uptime -p | sed -e 's/up /Uptime: /g')"

	local menu="$lockscreen\n$logoff\n$shutdown\n$restart\n"
	choice="$(printf "$menu" | rofi_cmd )"

	case "$choice" in
		"$lockscreen")
			xfce4-screensaver-command -l ;;
		"$logoff")
			xfce4-session-logout --logout ;;
		"$shutdown")
			systemctl poweroff ;;
		"$restart")
			systemctl reboot ;;
	esac
}

main
