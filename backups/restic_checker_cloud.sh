#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY=""
export RESTIC_PASSWORD=password

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

restic check --read-data


