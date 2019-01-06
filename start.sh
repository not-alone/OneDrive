#!/bin/bash
if [ ! -f /OneDriveConf/refresh_token ]
then
  echo "OneDrive Authentication" >> /OneDriveConf/log.txt 2>&1
  echo $ONEDRIVE_AUTH | /usr/local/bin/onedrive --confdir /OneDriveConf >> /OneDriveConf/log.txt 2>&1
fi

if [ ! -f /OneDriveConf/config ]
then
  echo "Creating Config File" >> /OneDriveConf/log.txt 2>&1
  cp -f /home/nobody/.config/onedrive/config /OneDriveConf/config
fi

if [ -f /OneDriveConf/refresh_token ]
then
  echo "Running OneDrive" >> /OneDriveConf/log.txt 2>&1
  umask 0000
  /usr/local/bin/onedrive $ONEDRIVE_COMMANDS --confdir /OneDriveConf --syncdir /OneDriveData >> /OneDriveConf/log.txt 2>&1
fi
