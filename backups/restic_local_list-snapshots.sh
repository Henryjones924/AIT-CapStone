#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY="/mnt/backups/restic"
export RESTIC_PASSWORD=


restic snapshots
