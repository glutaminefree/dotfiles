#!/bin/bash

CONTAINERS=$(docker ps -a -q)

if [[ -z "$CONTAINERS" ]]
then
    echo "Nothing to do."
    exit
fi

echo 'Cleaning ...'
docker stop $CONTAINERS
docker rm   $CONTAINERS
echo 'Done'
