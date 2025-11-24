#!/bin/bash

#list of running container IDs
containers=$(docker ps -q)

#each container and pause it
for container_id in $containers; do
        docker pause "$container_id" >/dev/null
done
sleep 20
