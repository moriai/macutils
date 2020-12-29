#!/bin/bash

vers=($(sw_vers -productVersion | sed 's/\./ /g'))
vernum=$(printf "%d%02d" ${vers[0]} ${vers[1]})

if [ $vernum -ge 1010 ]; then
	defaults write com.apple.dock ResetLaunchPad -bool true
elif [ $vernum -ge 1000 ]; then
	rm -f "$HOME/Library/Application Support/Dock/"*.db
else
	echo "$0: unsupported macOS version"
	exit 1
fi

killall Dock
