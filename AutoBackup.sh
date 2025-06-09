#!/bin/bash
####################
#This script can be used to create a backup copy of files that have not been edited for a specified period of time.
#The user can enter a directory to backup, the files from this directory are checked and the time difference is calculated
####################
echo "Which directory do you want to back up? (absolute path): "
read dir_to_backup
echo "Directory where you want to store the backup (absolute path): "
read dir_where_backup

dir_to_backup=$dir_to_backup
dir_where_backup=$dir_where_backup
days=1
current_date=$(date +%s)

if [ ! -d "$dir_to_backup" ]; then
	echo "The directory you want to back up doesn't exist!"
	exit 1
fi

if [ ! -d "$dir_where_backup" ]; then
	echo "The directory to store the backup doesn't exist — creating it now."
	mkdir $dir_where_backup
fi

for data in "$dir_to_backup"/*
do
	file_date=$(stat -c %Y "$data")
	if [ $(((current_date - file_date) / 86400)) -gt "$days" ]; then
		echo "Backing up file: $data"
		cp "$data" "$dir_where_backup" 
	fi
done

echo "Backup created."

