#!/bin/bash
#
#This script monitors the system's RAM and CPU usage at a user-defined interval. 
#If RAM or CPU usage exceeds the provided limit, it prints a warning message and stops execution.
#
INTERVAL=$1
RAM_LIMIT=$2
CPU_LIMIT=$3

if [ $# -ne 3 ]; then
	echo "You didn't provide all arguments: interval, RAM limit and CPU limit!"
	exit 1
fi

while true; do
	DATE=$(date +"%Y-%m-%d %H:%M:%S")
	RAM_USAGE=$(free | awk '/Mem:/ {printf("%.2f", $3/$2 * 100)}' | tr ',' '.')
	CPU_USAGE=$(top -bn1 | awk '/%Cpu\(s\):/ {printf(100-$8)}' | tr ',' '.')

	echo "["$DATE"], RAM usage: "$RAM_USAGE", CPU usage: "$CPU_USAGE""

	if (( $(echo "$RAM_USAGE > $RAM_LIMIT" | bc -l) )) || (( $(echo "$CPU_USAGE > $CPU_LIMIT" | bc -l) )); then
		echo "RAM or CPU out of limit!"
		break
	fi

	sleep "$INTERVAL"
done
