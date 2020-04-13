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
BIN_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/bin
SRC_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/src
LOG_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/log
ETC_DIR=$WORKSPACE/$PACKAGE/opt/$PACKAGE_NAME/etc

FRONTEND_DIR=$SRC_DIR/frontend
SERVERSIDE_DIR=$SRC_DIR/serverside
BACKEND_DIR=$SRC_DIR/backend

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

echo 'VERIFYING IF CLONE WAS SUCESSFULL'
if [ ! -d $WORKSPACE/clueless_frontend ];        then exit 1; fi
if [ ! -d $WORKSPACE/clueless_serverside ];      then exit 1; fi
if [ ! -d $WORKSPACE/clueless_backend ];         then exit 1; fi
echo 'CLONE GOOD, CARRY ON'

echo 'GENERATING PACKAGE DIRECTORY:'
mkdir -v                                         $WORKSPACE/$PACKAGE

echo 'GENERATING PACKAGE SUBDIRECTORIES:'
mkdir -vp                                         $BIN_DIR
mkdir -vp                                         $SRC_DIR
mkdir -vp                                         $LOG_DIR
mkdir -vp                                         $ETC_DIR
mkdir -vp                                         $FRONTEND_DIR
mkdir -vp                                         $SERVERSIDE_DIR
mkdir -vp                                         $BACKEND_DIR


echo 'IMPORTING BIN:'
mv -v $WORKSPACE/clueless_serverside/clueless     $BIN_DIR       # CLI python script

echo 'IMPORTING ETC:'
mv -v $WORKSPACE/Clueless/etc/*                   $ETC_DIR

echo 'IMPORTING INSTALLATION CONFIGURATION:'
mv -v $WORKSPACE/Clueless/DEBIAN                  $PACKAGE
chmod -v 555                                      $WORKSPACE/$PACKAGE/DEBIAN/*

echo 'SETTING VERSION:'
sed -i "s/_VERSION_/${TAG_CONFIG}/g"              $WORKSPACE/$PACKAGE/DEBIAN/control

echo 'BUILDING INSTALLER:'
dpkg-deb --build $PACKAGE


