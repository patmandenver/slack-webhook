#!/bin/bash
#
# -- MIT license --
# Copyright (c) 2017 Patrick Bailey
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#########################################


######################
#
# Configuration
#   - Replace UPDATE-ME in SLACK_WEBHOOKS
#     with your own webhook ex.
#     https://hooks.slack.com/services/T0437LKLE/B07C8KSS3/XXXXXXXXXX 
#
######################

SLACK_WEBHOOK="UPDATE-ME"

PROJECT="slack-webhooks"
INSTALL_DIR="/"
VERSION="0.8"
ARCH="amd64"
PACKAGE="${PROJECT}_${VERSION}-${ARCH}"



# Must fill out UPDATE-ME fields
if [ $SLACK_WEBHOOK = "UPDATE-ME" ]; then
  echo "ERROR: SLACK_WEBHOOK variable has not been set in build.sh"
  exit 1
fi

# Must be run as sudo in order to change ownership of file
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with admin privileges 'sudo'"
    echo "Only to change the user:group of files in the debian package"
    echo "exiting...."
    exit 1
fi


# Control file
SECTION="Utilties"
PRIORITY="optional"
DEPENDS=""
MAINTAINER="Patrick Bailey <pbailey@10x13.com>"
DESCRIPTION="Slack Webhook
 A simple script to post messages to a slack using the incoming webhooks tool"
#Every new line in the description must have a space in front of it

echo "======================================="
echo "   Starting Build of $PROJECT" 
echo "======================================="
echo "VERSION: $VERSION"
echo "RELEASE: $RELEASE"
echo "PACKAGE_DIR: $PACKAGE_DIR"
echo "WORKING DIRECTORY: $(pwd)"
echo ""
echo "----  DEBIAN BUILD ----"
echo ""

######################################
#
# Create temporary folders for
# Debian package creation
#
######################################

DEB_BUILD_DIR="$(pwd)/deb"
PKG_BUILD_DIR="$DEB_BUILD_DIR/$PACKAGE"
if [[ -d $DEB_BUILD_DIR ]]; then
    rm -rf $DEB_BUILD_DIR
fi
mkdir -p $PKG_BUILD_DIR/DEBIAN
mkdir -p $PKG_BUILD_DIR/$INSTALL_DIR

######################################
#
# Create the Debian control file
#   https://www.debian.org/doc/debian-policy/ch-controlfields.html
#
######################################
# Write the Debian Control file...
echo "Updating: $DEB_BUILD_DIR/DEBIAN/control"
cat <<EOF > $PKG_BUILD_DIR/DEBIAN/control
Package: $PROJECT
Version: $VERSION
Section: $SECTION
Priority: $PRIORITY
Depends: $DEPENDS
Architecture: $ARCH
Maintainer: $MAINTAINER
Description: $DESCRIPTION
EOF

######################################
#
# Create a tar file that contains
#  All base folders in the repo except 
#  the build director and its contents
#  ... yes you could just copy the files 
#  up but the ignore.txt is pretty 
#  convenient
#
######################################
tar -X ignore.txt -czvf $DEB_BUILD_DIR/$PROJECT.tgz -C .. .


######################################
#
# Expand the tar file that was just 
# created into the package folder
# that currently contains the
# DEBIAN/control file
#
######################################
tar -xzvf $DEB_BUILD_DIR/$PROJECT.tgz -C $PKG_BUILD_DIR/$INSTALL_DIR
rm $DEB_BUILD_DIR/$PROJECT.tgz

######################################
#
# Change owner of all files to root:root
#
######################################
chown -R root:root $DEB_BUILD_DIR/$PACKAGE

######################################
#
# Build the debian package
#
######################################
cd $DEB_BUILD_DIR
dpkg-deb -v --build $PACKAGE
cd ..

mv $DEB_BUILD_DIR/$PACKAGE.deb .

echo ""
echo "======================================================"
echo " == Debian package $PACKAGE created  "
echo " =="
echo " == To check package contents run "
echo " == dpkg -c $PACKAGE.deb"
echo " =="
echo " == To install $PACKAGE"
echo " == sudo dpkg -i $PACKAGE.deb"
echo " =="
echo " == To un-install"
echo " == sudo dpkg --remove $PROJECT" 
echo "======================================================"
