#!/bin/bash
export RESTIC_REPOSITORY="/backup/restic"
export RESTIC_PASSWORD_FILE="/backup/.env"

restic check --read-data
