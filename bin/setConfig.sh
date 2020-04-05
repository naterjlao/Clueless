#!/bin/bash
################################################################################
# File: setConfig.sh
# Language: Bash
# Author: Nate Lao (nlao1@jh.edu)
# Date Created: 4/5/2020
# Description:
#          Generates the appropriate configuration for the FrontEnd, BackEnd and
#          ServerSide based on the central configuration in
#          /opt/clueless/etc/clueless.config
################################################################################

TMP_DIR=/opt/clueless/tmp
ETC_DIR=/opt/clueless/etc
SRC_DIR=/opt/clueless/src

mkdir -v $TMP_DIR

# Import the configuration from central configuration
source $ETC_DIR/clueless.config

################################################################################
# FrontEnd Configuration
################################################################################
FRONTEND_CONFIG_DIR=$SRC_DIR/frontend/src/environments
FRONTEND_CONFIG='environment.ts'
FRONTEND_CONFIG_TEMPLATE='environment.ts.template'

touch $TMP_DIR/$FRONTEND_CONFIG

# Generate the configuration file for the FrontEnd
cat  $ETC_DIR/$FRONTEND_CONFIG_TEMPLATE              > $TMP_DIR/$FRONTEND_CONFIG
echo 'export const network = {'                     >> $TMP_DIR/$FRONTEND_CONFIG
echo "httpPort: \"$HTTP_PORT\","                    >> $TMP_DIR/$FRONTEND_CONFIG
echo "serverIP: \"$SERVER_IP\","                    >> $TMP_DIR/$FRONTEND_CONFIG
echo "serverPort: \"$SERVER_PORT\""                 >> $TMP_DIR/$FRONTEND_CONFIG
echo '};'                                           >> $TMP_DIR/$FRONTEND_CONFIG

# Send to the FrontEnd configuration directory
cp -v $TMP_DIR/$FRONTEND_CONFIG $FRONTEND_CONFIG_DIR/$FRONTEND_CONFIG

################################################################################
# ServerSide Configuration
################################################################################
# TODO

################################################################################
# BackEnd Configuration
################################################################################
# TODO

rm -rvf $TMP_DIR