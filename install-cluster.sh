#!/bin/bash

./ambari-shell.sh << EOF
blueprint add --file /tmp/kylin-singlenode.json
cluster build --blueprint hdp-singlenode-kylin
cluster autoAssign
cluster create --exitOnFinish true
EOF

clear

SERF_RPC_ADDR=${AMBARISERVER_PORT_7373_TCP##*/}
serf event --rpc-addr=$SERF_RPC_ADDR kylin

./wait-for-kylin.sh
