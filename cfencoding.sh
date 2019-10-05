#!/bin/bash

CFENCODINGFILE=~/.CFUserTextEncoding
PROGNAME="$0"

case $# in
0)
	echo -n 'Init '
	cat ${CFENCODINGFILE}
	echo
	echo -n 'Env '
	echo ${__CF_USER_TEXT_ENCODING}
	exit 0
	;;
*)
	case $1 in
	en)	ENCODING='0:0' ;;
	ja)	ENCODING='1:14' ;;
	*)	echo "$PROGNAME: Unknown encoding" >&2; exit 1;;
	esac
	;;
esac

case $# in
1)
	echo -n ${ENCODING} >${CFENCODINGFILE}
	exit 0
	;;
*)
	shift
	XUID=`id -u | awk '{printf "0x%X", $0}'`
	__CF_USER_TEXT_ENCODING="${XUID}:${ENCODING}" exec "$@"
	;;
esac
