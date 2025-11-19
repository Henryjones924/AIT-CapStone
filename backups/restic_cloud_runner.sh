#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY=""
export RESTIC_PASSWORD=

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=


#restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune

#restic forget c0542854 c0542854 31b147d4 2d916816 074cee3e b9e9ae84 b9e9ae84 61f83afd d5c8df76 9847ea41 d42a2d7c 6479e49f 566f846c 4cc0340a f34db082 8289e3db 06de4290 d24b4cf7
restic check --read-data 



