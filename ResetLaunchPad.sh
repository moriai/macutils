#!/bin/bash

vers=($(sw_vers -productVersion | sed 's/\./ /g'))

case ${vers[0]} in
10)	;;
*)	echo "$0: unsupported macOS version"; exit 1 ;;
esac

if [[ ${vers[1]} -ge 10 ]]; then
	defaults write com.apple.dock ResetLaunchPad -bool true
else
	rm -f "$HOME/Library/Application Support/Dock/"*.db
fi 

killall Dock
