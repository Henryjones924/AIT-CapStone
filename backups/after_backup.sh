#!/bin/bash

# Get list of paused container IDs
containers=$(docker ps -q --filter status=paused)

for container_id in $containers; do
    docker unpause $container_id >/dev/null
    sleep 2
done
sleep 3
#echo "UnPause Completed"
