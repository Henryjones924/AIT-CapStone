#!/bin/bash
HOST="node01"
SSH_KEY="/home/ansible/.ssh/id_rsa_fips"
#Copy backup from Node to controller
scp -i "$SSH_KEY" ansible@$HOST:/tmp/restic.tgz /home/henry/ansible/docker/backup-repo