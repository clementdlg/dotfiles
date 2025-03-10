#!/usr/bin/env bash
set -xueo pipefail

theme="$HOME/.config/rofi/theme/main.rasi"

get_title() {
	# currently playing
	local play_status="$(playerctl status)"
	local title=""
	if [[ "$play_status" != "Stopped" ]]; then
		title="$(playerctl metadata --format "{{ title }} - {{ artist }}")"
	fi

	icon=""
	[[ "$play_status" == "Paused" ]] && icon=""
	echo "$icon $title"
}

rofi_cmd() {
	title="$(get_title)"

	if [[ -z "$title" ]]; then
		rofi show -dmenu -p "Audio I/O" -theme "${theme}"
	else
		rofi show -dmenu -p "Audio I/O" -theme "${theme}" -mesg "$title"
	fi
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

	icon="/usr/share/icons/Papirus/48x48/status/notification-audio-volume-medium.svg"
	notify-send -i "$icon" "Bluetooth Applet" "$message"
}

get_sink_description() {
    local sink_name="$1"
	local sink="$(pactl list sinks | grep -A1 "Name: $sink_name" | sed 1d | cut -f2 -d:)"
	echo "${sink:1}"
}

get_sink_by_description() {
    local description="$1"
	local sink="$(pactl list sinks | grep -B1 "Description: $description" | sed 2d | cut -f2 -d:)"
	echo "${sink:1}"
}

get_outputs() {
    pactl list sinks short | while read -r line; do
        local sink_name=$(echo "$line" | awk '{print $2}')
        local description="$(get_sink_description "$sink_name")"
        echo "$description"
    done
}

output_menu() {
    local outputs=$(get_outputs)
    
    if [ -z "$outputs" ]; then
        notify "No audio output devices found."
        exit 0
    fi

	local choice="$(echo "$outputs" | rofi_cmd "Audio Outputs" )"

	[[ -z "$choice" ]] && return 0

	local sink_name="$(get_sink_by_description "$choice")"

    if [ -n "$sink_name" ]; then
        pactl set-default-sink "$sink_name" 
        notify "Output : $choice"
    fi
}

are_speakers_muted() {
	cmd="$(amixer get Master | grep -oE '\[on\]|\[off\]' | sed 1d)"

	if [[ "$cmd" == "[off]" ]]; then
		return 0
	else
		return 1
	fi
}

is_muted() {
	local device="$1"

	cmd="$(amixer get "$device" | grep -oE '\[on\]|\[off\]' | sed 1d)"

	if [[ "$cmd" == "[off]" ]]; then
		return 0
	else
		return 1
	fi
}

main() {
	is_installed "pactl"
	is_installed "notify-send"
	is_installed "rofi"
	is_installed "playerctl"
	
	# menu items
	local outputs="󰓃 Audio Outputs"
	local inputs=" Audio Inputs"

	local speakers=" Mute Speakers"
	local mic=" Mute Microphone"

	is_muted "Master" && speakers=" Unmute Speakers"
	is_muted "Capture" && mic=" Unmute Microphone"

	local gui_app=" Audio Mixer"
	local menu="$outputs\n$speakers\n$inputs\n$mic\n"

	# display rofi menu
	local choice="$(printf "$menu" | rofi_cmd)"

	case "$choice" in
		"$outputs")
			output_menu ;;
		"$speakers")
			echo "not implemented" ;;
		"$inputs")
			echo "not implemented" ;;
		"$mic")
			echo "not implemented" ;;
	esac
}
main
