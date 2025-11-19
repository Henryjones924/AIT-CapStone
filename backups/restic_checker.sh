#!/bin/bash
export RESTIC_REPOSITORY="/mnt/backups/restic"
export RESTIC_PASSWORD=

restic check --read-data
