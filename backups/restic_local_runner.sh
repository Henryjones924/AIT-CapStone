#!/bin/bash
export RESTIC_REPOSITORY="/mnt/backups/restic"
export RESTIC_PASSWORD=

#restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune

#restic forget 3f010f80

#DIRECTORIES="/home /etc /var/log/syslog  /opt/DockerComposeFile /mnt/data/docker/compose /opt/scripts /mnt/data/docker/data/427680.427680/volumes"
#restic backup -v $DIRECTORIES


restic ls --long dea2f08a


