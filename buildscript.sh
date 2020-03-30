#!/bin/bash
##############################################################################
# File: buildscript.sh
# Author: Nate Lao (nlao1@jh.edu)
# Created On: 3/29/2020
# Description:
#       Builds the Debian .deb installer for project Clueless
##############################################################################

# Get the configuration for the build
source $WORKSPACE/clueless_config/config.sh

echo 'BUILDING DEBIAN PACKAGE WITH THE FOLLOWING CONFIGURATION:'
echo "TAG_FRONTEND=${TAG_FRONTEND}"
echo "TAG_SERVERSIDE=${TAG_SERVERSIDE}"
echo "TAG_BACKEND=${TAG_BACKEND}"

# Generate the installation directories
# TODO

# Copy artifacts the appropriate places
# TODO