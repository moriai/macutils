#!/bin/bash

USAGE="Usage: docker-system [ps|stop|cont]"

function supervisor_pid () {
	ps axc | awk '/com.docker.supervisor/ {print $1}'
}

case $# in
0)
	echo "$USAGE"
	;;
*)
	case $1 in
	ps)
		ps axjc | awk 'NR==1{print $0} /[Dd]ocker/{print $0}' | cut -c 1-34,47-51,59-
		;;
	stop)
		kill -STOP -`supervisor_pid`
		;;
	cont|resume|start)
		kill -CONT -`supervisor_pid`
		;;
	supervisor)
		echo `get_supervisor_id`
		;;
	*)
		echo "$USAGE"
	esac
	;;
esac
