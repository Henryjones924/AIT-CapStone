#!/bin/bash
HOST="node01"
SSH_KEY="/home/ansible/.ssh/id_rsa_fips"
#Place backup from controller to node
scp -i "$SSH_KEY" /home/henry/ansible/docker/backup-repo/restic.tgz ansible@$HOST:/tmp/restic.tgz