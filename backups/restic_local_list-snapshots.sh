#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY="/backup/restic"
export RESTIC_PASSWORD_FILE="/backup/.env"


restic snapshots
