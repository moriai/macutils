#!/bin/sh

TMPFILE=`mktemp` || exit 1

system_profiler -xml SPAirPortDataType >$TMPFILE

cur=":0:_items:0:spairport_airport_interfaces:0:spairport_current_network_information:"
oth=":0:_items:0:spairport_airport_interfaces:0:spairport_airport_other_local_wireless_networks:"

PlistBuddy -c "print $cur" -c "print $oth" $TMPFILE | awk '
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

rm -f $TMPFILE

