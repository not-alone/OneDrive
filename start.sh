#!/bin/bash
umask 0000
if [ ! -f /OneDriveConf/refresh_token ]
then
  echo "OneDrive Authentication"
  /usr/local/bin/onedrive --confdir /OneDriveConf
fi

if [ ! -f /OneDriveConf/config ]
then
  echo "Creating Config File"
  cp -f /home/nobody/config /OneDriveConf/config
fi

if [ -f /OneDriveConf/refresh_token ]
then
  echo "Running OneDrive"
  /usr/local/bin/onedrive $ONEDRIVE_COMMANDS --monitor --verbose --confdir /OneDriveConf --syncdir /OneDriveData
fi
