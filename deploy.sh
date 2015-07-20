#!/bin/sh

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions

function error() {
SCRIPT="$0"           # script name
LASTLINE="$1"         # line of error occurrence
LASTERR="$2"          # error code
echo "ERROR exit from ${SCRIPT} : line ${LASTLINE} with exit code ${LASTERR}"
exit 1
}

trap 'error ${LINENO} ${?}' ERR

echo ""
echo "Welcome to use Kylin-Deploy script"
echo "This script will help you:"
echo "1. Check environment"
echo "2. Prepare sample cube related data"
echo "3. Lauch a web service to build cube and query with (at http://localhost:7070/kylin)"
echo "Please make sure you're running this script on a hadoop CLI machine, and you have enough permissions."
echo ""


KYLIN_HOME=/usr/local/kylin
echo "Kylin home folder path is $KYLIN_HOME"
cd $KYLIN_HOME


echo "Create sample cube..."
source ./bin/sample.sh


echo "Starting kylin server..."
source ./bin/kylin.sh start

echo "Kylin server started"

echo "Kylin-Deploy Success!"
echo "Please visit http://<your_sandbox_ip>:7070/kylin to play with the cubes!"
