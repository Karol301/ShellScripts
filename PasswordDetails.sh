#!/bin/bash
#
#This script is responsible for showing details of users password
#
echo "Name of user who you want to analyze:"
read name

username=$name

if grep -q "^$username" /etc/shadow; then
	echo "Username: $username"
	
	HashedPassword=$(grep "^$username" /etc/shadow | cut -d':' -f2)
	echo "Hashed password: $HashedPassword"

	DaysToChangePassword=$(grep "^$username" /etc/shadow | cut -d':' -f4)
	echo "Number of days after which the password can be changed again: $DaysToChangePassword"

	DaysOfValidPassword=$(grep "^$username" /etc/shadow | cut -d':' -f5)
	echo "Number of days the password is valid: $DaysOfValidPassword"
	
	DaysToNotifications=$(grep "^$username" /etc/shadow | cut -d':' -f6)
	echo "Number of days before password expiration when user receives notification: $DaysToNotifications"
else 
	echo "No user with username $username"
fi
