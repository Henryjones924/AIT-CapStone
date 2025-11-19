#!/bin/bash

# Get list of running container IDs
containers=$(docker ps -q)

# Iterate through each container and pause it
for container_id in $containers; do
        
        
        docker pause $container_id >/dev/null
done
sleep 20
#echo 'Container Puase Completed'
