#!/bin/bash
[ -z $PGID ] && { PGID=1000; }
[ -z $PUID ] && { PUID=1000; }

# group for app
[ $( getent group app | wc -l ) -gt 0 ] && { groupdel app; }
groupadd -g $PGID app
# user
[ $( getent passwd app | wc -l ) -gt 0 ] && { userdel app; }
useradd -g app -u $PUID -s /bin/bash -m app

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
  su app -c "/usr/local/bin/onedrive --monitor --verbose --confdir /OneDriveConf --syncdir /OneDriveData"
fi



