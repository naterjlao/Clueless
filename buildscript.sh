#!/bin/bash
##############################################################################
# File: buildscript.sh
# Author: Nate Lao (nlao1@jh.edu)
# Created On: 3/29/2020
# Description:
#       Builds the Debian .deb installer for project Clueless
##############################################################################

##############################################################################
# Build configuration
##############################################################################
$PACKAGE_NAME='clueless'
$PACKAGE=${PACKAGE_NAME}_$TAG_CONFIG
source $WORKSPACE/clueless_config/config.sh

##############################################################################
# Main
##############################################################################

echo "BUILDING DEBIAN PACKAGE $PACKAGE"

echo 'BUILDING DEBIAN PACKAGE WITH THE FOLLOWING CONFIGURATION:'
echo "TAG_FRONTEND=${TAG_FRONTEND}"
echo "TAG_SERVERSIDE=${TAG_SERVERSIDE}"
echo "TAG_BACKEND=${TAG_BACKEND}"

echo 'CLONING SUBSYSTEMS:'
git clone --branch $TAG_FRONTEND git@github.com:naterjlao/clueless_frontend.git
git clone --branch $TAG_SERVERSIDE git@github.com:naterjlao/clueless_serverside.git
git clone --branch $TAG_BACKEND git@github.com:naterjlao/clueless_backend.git

echo 'GENERATING PACKAGE DIRECTORY:'
mkdir -v $WORKSPACE/$PACKAGE

echo 'GENERATING PACKAGE SUBDIRECTORIES:'
mkdir -v  $WORKSPACE/$PACKAGE
mkdir -vp $WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/frontend
mkdir -vp $WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/serverside
mkdir -vp $WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/backend
mkdir -vp $WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/log

# Copy artifacts the appropriate places
# TODO







