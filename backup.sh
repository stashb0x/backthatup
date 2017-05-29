#!/bin/bash

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.


src=~/
dest=~/

# Date today
todays_date=$(date +%m-%d-%Y)
file_to_test=backup-$todays_date.tar.gz

echo "This simple script will backup the directory that you specify."
echo "You will need to change the source directory(directory that you would like to backup) and destination directory
(directory to keep the backup tar file in) otherwise this script will default backing up your home directory and storing \
the backup tar file there."
echo
echo "When the script is finished it will run a md5 check on the file and copy the checksum to a file labeled md5-TODAYS-DATE.txt \
this way you can always run a md5sum -c on a later date on the md5-TODAYS-DATE.txt file."
echo
echo "If everything went well the script will print out :Ok at the end after running the md5sum on the backup file"
     
# Check that there is a drive plugged in
if $(mountpoint -q /media/$USER/Passport); then
  # Advise that the backup is starting
  echo "Starting backup this could take sometime..."
  echo
  # Compress archive and advise of directories to exclude from the backup.
  tar --exclude="backup-$todays_date.tar.gz" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src $dest  
  echo
  # Advise that the backup is now complete.
  echo "Backup is now complete."
  echo
elif $(mountpoint -q /run/media/$USER/Passport); then 
  # Advise that the backup is starting
  echo "Starting backup this could take sometime.."
  echo
  tar --exclude="backup-$todays_date.tar.gz" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src $dest  
elif $(mountpoint -q /home/$USER/Mount); then
  tar --exclude="backup-$todays_date.tar.gz" --exclude=".*" -czvf backup-$todays_date.tar.gz -g backup-$todays_date.snar $src $dest  
  # Compress archive and advise of directories to exclude from the backup.
  echo
else
  # Advise that the drive is not mounted and show what drives are mounted.
  echo "Drive does not appear to be mounted. Here is what drives are mounted"
  df -h
  echo
fi
echo
# Create a checksum for generated backups
file_checksum=$(md5sum $file_to_test)
echo $file_checksum > md5-$todays_date.txt
echo
echo $(md5sum -c /home/$USER/md5-$todays_date.txt)
echo

