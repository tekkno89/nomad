#!/bin/bash

# *********************************************************************
# Name:      Nomad
# Author:    Tyler K
# Date:      2016-12-19
# Purpose:   Simple script to create Vagrant project directory and Vagrantfile
#
# Notes:
# Change Log
# Date           Name           Description
#
# *********************************************************************


# variables for vagrantfile
VMBOX='ubuntu/trusty64'
VMNAME='vagrant'
VMGUI='false'
VMMEM='1024'

usage() {
echo "
Create directory and Vagrant file for new project

Usage:  $0 [-h] [-b] [-g] [-m] DIRECTORY PROJECT_NAME
        -h  help
        -b  Box that you would like to use for project. Default $VMBOX
        -g  Enable VirtualBox GUI. Default $VMGUI
        -m  Set Vagrant box memory. Default $VMMEM

Example:
   $0 -b ubuntu/trusty64 /home/USER/vagrant/ test_box

Example (Set Vagrant Box with 2GB Ram):
   $0 -m 2048 /home/USER/vagrant/ test_box
"
}

# Show usage if there are no operands
if [ $1 = '-h' ]; then
  usage
  exit 1
fi

# Show usage if there are no operands
if [ $# -lt 2 ]; then
  usage
  exit 1
fi

while getopts "?hb:g:m:" OPTION; do
  case $OPTION in
    h)  usage; exit 1;;
    b)  VMBOX=$OPTARG;;
    g)  VMGUI=$OPTARG;;
    m)  VMMEM=$OPTARG;;
  esac
done

# Show usage if there are no operands
if [ $(( $# - $OPTIND )) -lt 1 ]; then
  usage
  exit 1
fi

export VMBOX VMGUI VMMEM VMNAME

DIRECTORY=${@:$OPTIND:1}
PROJECT_NAME=${@:$OPTIND+1:1}

mkdir $DIRECTORY/$PROJECT_NAME
touch $DIRECTORY/$PROJECT_NAME/Vagrantfile
envsubst < Vagrantfile.template > $DIRECTORY/$PROJECT_NAME/Vagrantfile
