#!/bin/bash
#
#This script is used to provide information about permissions to any file for user
#
echo "Which file do you want to analize? "
read file

FileName=$file

if ls | grep -q "$FileName"; then
	permissions=$(ls -l "$FileName" | cut -d' ' -f1)
	echo "File permissions: $FileName: $permissions" 
	if [ -w "$FileName" ] && [ -r "$FileName" ] && [ -x "$FileName" ]; then
        	echo "You can write, read and execute"
    	elif [ -w "$FileName" ] && [ -r "$FileName" ]; then
        	echo "You can write and read"
    	elif [ -w "$FileName" ] && [ -x "$FileName" ]; then 
        	echo "You can write and execute"
    	elif [ -r "$FileName" ] && [ -x "$FileName" ]; then
        	echo "You can read and execute"
    	elif [ -r "$FileName" ]; then
        	echo "You can only read"
    	elif [ -w "$FileName" ]; then
        	echo "You can only write"
    	elif [ -x "$FileName" ]; then
        	echo "You can only execute"
    	else
        	echo "You don't have permissions"
	fi
else
    echo "No file with name: $FileName in your directory"
fi

