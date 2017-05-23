#!/bin/bash

src=~/
dest=~/

# Date today
todays_date=$(date +%m-%d-%Y)

# Check that there is a drive plugged in
if $(mountpoint -q /media/$USER/Passport); then
  # Advise that the backup is starting
  echo "Starting backup this could take sometime..."
  echo
  # Compress archive and advise of directories to exclude from the backup.
  tar --exclude="backup-$todays_date.tar.gz" --exclude="/proc" --exclude="/var" --exclude="/tmp" --exclude="/usr/src/" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src  $dest  
  echo
  # Advise that the backup is now complete.
  echo "Backup is now complete."
  echo
elif $(mountpoint -q /run/media/$USER/Passport); then 
  # Advise that the backup is starting
  echo "Starting backup this could take sometime.."
  echo
  tar --exclude="backup-$todays_date.tar.gz" --exclude="/proc" --exclude="/var" --exclude="/tmp" --exclude="/usr/src/" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src  $dest  
elif $(mountpoint -q /home/$USER/Mount); then
  tar --exclude="backup-$todays_date.tar.gz" --exclude="/proc" --exclude="/var" --exclude="/tmp" --exclude="/usr/src/" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src  $dest  
  # Compress archive and advise of directories to exclude from the backup.
  echo
else
  # Advise that the drive is not mounted and show what drives are mounted.
  echo "Drive does not appear to be mounted. Here is what drives are mounted"
  df -h
  echo
fi
#find ~/ | grep backup-$todays_date.tar.gz
