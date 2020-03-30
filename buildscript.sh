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
PACKAGE_NAME='clueless'
PACKAGE="${PACKAGE_NAME}_${TAG_CONFIG}"
FRONTEND_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/frontend
SERVERSIDE_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/serverside
BACKEND_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/backend
LOG_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/log
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
find . -name ".git" | xargs -I{} rm -rf {} # cloning leaves this, should not be installed on system

echo 'GENERATING PACKAGE DIRECTORY:'
mkdir -v  $WORKSPACE/$PACKAGE

echo 'GENERATING PACKAGE SUBDIRECTORIES:'
mkdir -vp $FRONTEND_DIR
mkdir -vp $SERVERSIDE_DIR
mkdir -vp $BACKEND_DIR
mkdir -vp $LOG_DIR

echo 'IMPORTING SUBSYSTEMS:'
mv -v $WORKSPACE/$PACKAGE/clueless_frontend/*     $FRONTEND_DIR
mv -v $WORKSPACE/$PACKAGE/clueless_serverside/*   $SERVERSIDE_DIR
mv -v $WORKSPACE/$PACKAGE/clueless_backend/*      $BACKEND_DIR

echo 'IMPORTING INSTALLATION CONFIGURATION:'
mv -v $WORKSPACE/Clueless/DEBIAN                  $PACKAGE

echo 'SETTING VERSION:'
sed -i "s/_VERSION_/${TAG_CONFIG}/g"              $WORKSPACE/$PACKAGE/DEBIAN/control

echo 'BUILDING INSTALLER:'
dpkg-deb --build $PACKAGE


