#!/bin/bash
[ -z $GID ] && { GID=1000; }
[ -z $UID ] && { UID=1000; }

# group for app
[ $( getent group app | wc -l ) -gt 0 ] && { groupdel app; }
groupadd -g $GID app
# user
[ $( getent passwd app | wc -l ) -gt 0 ] && { userdel app; }
useradd -g app -u $UID -s /bin/bash -m app

if [ ! -f /OneDriveConf/refresh_token ]
then
  echo "OneDrive Authentication"
  /usr/local/bin/onedrive --confdir /OneDriveConf
fi
if [ ! -f /OneDriveConf/config ]
then
  echo "Creating Config File" 
  mv /root/config /OneDriveConf/
fi
if [ -f /OneDriveConf/refresh_token ]
then
  chown -R app:app /OneDriveData
  chown -R app:app /OneDriveConf
  echo "Running OneDrive"
  su app -c "/usr/local/bin/onedrive $ONEDRIVE_COMMANDS --monitor --verbose --confdir /OneDriveConf --syncdir /OneDriveData"
fi



