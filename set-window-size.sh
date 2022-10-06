#!/usr/bin/env bash

#WIDTH=1600
#HEIGHT=1000 #or 900
WIDTH=1280
HEIGHT=800


if [ $# -lt 1 ]; then
	echo "usage: $0 ApplicationName"
	exit 1
fi


case "$1" in
Excel|PowerPoint|Word)
	appName="Microsoft $1" ;;
*)
	appName="$1" ;;
esac


case "$appName" in
"Microsoft PowerPoint")
	osascript -e '
		tell application "Microsoft PowerPoint"
		activate
		set width of document windows of active presentation to '$WIDTH'
		set height of document windows of active presentation to '$HEIGHT'
		end tell'

	;;
*)
	osascript -e '
		tell application "'$1'"
		activate
		set bounds of front window to {0, 0, '$WIDTH', '$HEIGHT'}
		end tell'
	;;
esac
