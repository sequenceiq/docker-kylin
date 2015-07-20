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
echo "2. Build Kylin artifacts"
echo "3. Prepare test cube related data"
echo "4. Lauch a web service to build cube and query with (at http://localhost:7070/kylin)"
echo "Please make sure you're running this script on a hadoop CLI machine, and you have enough permissions."
echo "Also, We assume you have installed: JAVA, TOMCAT, NPM and MAVEN."
echo "[Warning] The installation may break existing tomcat applications on this CLI"
echo ""

echo "Checking JAVA status..."

if [ -z "$JAVA_HOME" ]
then
    echo "Please set $JAVA_HOME so that Kylin-Deploy can proceed"
    exit 1
else
    echo "JAVA_HOME is set to $JAVA_HOME"
fi

if [ -d "$JAVA_HOME" ]
then
    echo "$JAVA_HOME exists"
else
    echo " $JAVA_HOME does not exist or is not a directory."
    exit 1
fi

echo "Checking tomcat status..."

if [ -z "$CATALINA_HOME" ]
then
    echo "Please set CATALINA_HOME so that Kylin-Deploy knows where to start tomcat"
    exit 1
else
    echo "CATALINA_HOME is set to $CATALINA_HOME"
fi

if [ -d "$CATALINA_HOME" ]
then
    echo "$CATALINA_HOME exists"
else
    echo " $CATALINA_HOME does not exist or is not a directory."
    exit 1
fi

echo "Checking maven..."

if [ -z "$(command -v mvn)" ]
then
    echo "Please install maven first so that Kylin-Deploy can proceed"
    exit 1
else
    echo "maven check passed"
fi

echo "Checking npm..."

if [ -z "$(command -v npm)" ]
then
    echo "Please install npm first so that Kylin-Deploy can proceed"
    exit 1
else
    echo "npm check passed"
fi

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
