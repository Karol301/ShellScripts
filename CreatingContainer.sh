#!/bin/bash
#
# This script removes a Docker image provided by the user
# and creates a new one based on the given Dockerfile path.
#

if [ $# -eq 2 ]; then
    ImageName=$1
    DockerFilePath=$2
    echo "-----------------------"
    docker images | grep "$ImageName"
    echo "-----------------------"

    echo "Do you want to remove this image? y/n"
    read answer1
    if [ "$answer1" = "y" ]; then
        docker rmi "$ImageName"
    fi

    echo "Do you want to create new image base on $DockerFilePath? y/n"
    read answer2
    if [ "$answer2" = "y" ]; then
        docker build -t "$ImageName" "$DockerFilePath"
    fi

    echo "-----------------------"
    docker images | grep "$ImageName"
    echo "-----------------------"
else
    echo "You have to provide ImageName and DockerFilePath"
    exit 1
fi