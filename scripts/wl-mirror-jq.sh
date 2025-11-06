#!/bin/sh

set -x

wl-mirror \
	-F  \
	--scaling fit \
	$(hyprctl monitors -j | jq -r .[1].name) &
