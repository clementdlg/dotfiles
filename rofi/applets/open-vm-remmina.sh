#!/usr/bin/env bash

# this script is used to connect to VMs running the Spice server

uri="qemu:///system"

# viewer command
viewer() {

which remmina &>/dev/null
if [[ $? -eq 0 ]]; then
	echo "remmina -c"
	return
fi

which flatpak &>/dev/null
if [[ $? -ne 0 ]]; then
	return
fi

flatpak list | grep remmina >/dev/null
if [[ $? -eq 0 ]]; then
	echo "flatpak run org.remmina.Remmina -c"
	return
fi
return
}

viewerCmd=$(viewer)

if [[ -z "$viewerCmd" ]]; then
	echo "Error : Remmina is not installed"
	exit 1
fi

# menu command
which rofi &>/dev/null
rofi="$?"

if [[ $rofi -ne 0 ]]; then
	echo "Error : Rofi must be installed" >&2
	exit 1
fi

menu="rofi show -dmenu"

# running vms
running=$(virsh -c "$uri" list | tail -n +3 | head -n -1 | awk '{print $2}')

# if no vms are active, exit
if [[ -z "$running" ]]; then
	exit 0
fi

# getting vm name
vm=$(printf "%s\n" $running | $menu)

# vm must not be empty
if [[ -z "$vm" ]]; then
	exit 0
fi

# getting spice address
spice=$(virsh -c "$uri" domdisplay --domain "$vm")

# opening display
$viewerCmd $spice &>/dev/null
