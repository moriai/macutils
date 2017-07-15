#!/bin/sh

PLISTFILE=

while [ $# -gt 0 ]; do
	case "$1" in
	-f)	shift; PLISTFILE="$1" ;;
	*)	break ;;
	esac
	shift
done

case "$PLISTFILE" in
'')	TMPFILE=`mktemp` || exit 1
	system_profiler -xml SPAirPortDataType >$TMPFILE
	PLISTFILE=$TMPFILE
	;;
esac

cur=":0:_items:0:spairport_airport_interfaces:0:spairport_current_network_information:"
oth=":0:_items:0:spairport_airport_interfaces:0:spairport_airport_other_local_wireless_networks:"
prog='
BEGIN {
	dict = 0
}
/Dict {/ {
	split("", a)
	dict = 1
}
/}/ {
	if (dict) {
		print a["spairport_network_channel"], a["_name"], a["spairport_network_bssid"], a["spairport_signal_noise"]
		dict = 0
	}
}
/=/ {
	if ($1 == "spairport_network_channel") {
		split($3, ch, ",")
		a[$1] = ch[1]
	} else {
		a[$1] = $3
	}
}
'

PlistBuddy -c "print $cur" -c "print $oth" $PLISTFILE | awk "$prog"

if [ -e $TMPFILE ]; then
	rm -f $TMPFILE
fi
