#!/bin/bash
################################################################################
# File: modifyConfig.sh
# Language: Bash
# Author: Nate Lao (nlao1@jh.edu)
# Date Created: 4/5/2020
# Description:
#          Modifies the configuration in /opt/clueless/etc/clueless.config
# Usage:
#          modifyConfig.sh <TYPE> <VALUE>
# Where:
#          -TYPE: either 'serverip', 'serverport', 'httpport'
#          -VALUE: the value to be stored in the configuration
################################################################################

CONFIG=/opt/clueless/etc/clueless.config
LOG=/opt/clueless/log/clueless.log

# Check the number of arguments passed
if [[ $# -lt 2 ]]; then
	ERR_MESSAGE="ERROR: modifyConfig.sh - Incorrect Number of Arguments passed. Need two: <TYPE> <VALUE>"
	echo $ERR_MESSAGE 1>&2
	echo $ERR_MESSAGE >> $LOG
	exit 1
fi

# Arguments <TYPE=[serverip, serverport, httpport]> <VALUE>
TYPE=$1
VALUE=$2

# Find and replace the configuration line that needs to be modified in ETC
if   [[ $TYPE == 'serverip' ]]; then
	CONFIG_TAG='SERVER_IP'
elif [[ $TYPE == 'serverport' ]]; then
	CONFIG_TAG='SERVER_PORT'
elif [[ $TYPE == 'httpport' ]]; then
	CONFIG_TAG='HTTP_PORT'
else
	ERR_MESSAGE="ERROR: modifyConfig.sh - InvalidArgument TYPE=$TYPE given. Accepts 'serverip', 'serverport', 'httpport'"
	echo $ERR_MESSAGE 1>&2
	echo $ERR_MESSAGE >> $LOG
	exit 1
fi
	
sed -i "/$CONFIG_TAG/c $CONFIG_TAG='$VALUE'" $CONFIG
