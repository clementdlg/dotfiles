#!/usr/bin/env bash

if [[ -z "$1" ]]; then
	echo "Usage : $0 <applet>"
	exit 0
fi

applet="$1"
pid="$(pidof  "$applet")"

if [[ -z "$pid" ]]; then
	$applet >/dev/null --application-mode &
else
	kill "$pid"
fi
