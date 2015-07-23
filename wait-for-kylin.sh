#!/bin/bash

: ${KYLIN_HOST:=$AMBARISERVER_PORT_7070_TCP_ADDR}
: ${SLEEP:=2}
: ${DEBUG:=1}

: ${KYLIN_HOST:? kylin server address is mandatory, fallback is a linked containers exposed 7070}

debug() {
  [ $DEBUG -gt 0 ] && echo [DEBUG] "$@" 1>&2
}

get-server-state() {
  curl -s -o /dev/null -w "%{http_code}" $AMBARISERVER_PORT_7070_TCP_ADDR:7070/kylin/index.html
}

debug waits for kylin to start on: $KYLIN_HOST
while ! get-server-state | grep 200 &>/dev/null ; do
  [ $DEBUG -gt 0 ] && echo -n .
  sleep $SLEEP
done
[ $DEBUG -gt 0 ] && echo
debug kylin web started: $KYLIN_HOST:7070/kylin
