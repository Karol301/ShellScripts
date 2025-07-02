#!/bin/bash

echo "Give a directory where you want to clean old logs: "
read dir_to_clean

current_date=$(date +%s)

for file in "$dir_to_clean"/*.log
do
    file_date=$(stat -c %Y "$file")  
    age=$(( (current_date - file_date) / 86400 ))  

    if [ $age -gt 10 ]; then
        echo "Removing $file"
        rm "$file"
    fi
done
