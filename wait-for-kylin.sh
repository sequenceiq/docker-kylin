#!/bin/bash

: ${KYLIN_HOST:=$AMBARISERVER_PORT_9080_TCP_ADDR}
: ${SLEEP:=2}
: ${DEBUG:=1}

: ${KYLIN_HOST:? kylin server address is mandatory, fallback is a linked containers exposed 9080}

debug() {
  [ $DEBUG -gt 0 ] && echo [DEBUG] "$@" 1>&2
}

get-server-state() {
  curl \
    --connect-timeout 2 \
    -H 'Accept: text/plain' \
    $KYLIN_HOST:9080 \
    2>/dev/null
}

debug waits for kylin server: $KYLIN_HOST RUNNING ...
while ! get-server-state | grep RUNNING &>/dev/null ; do
  [ $DEBUG -gt 0 ] && echo -n .
  sleep $SLEEP
done
[ $DEBUG -gt 0 ] && echo
