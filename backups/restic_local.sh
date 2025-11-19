#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY="/mnt/backups/restic"
export RESTIC_PASSWORD=
# Setting up Logging
LOG_FILE="/var/log/restic/restic_local.log"

# Function to log messages with timestamps and types
log() {
    local type="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$type] $message" >> "$LOG_FILE"
}

# Log initial message
log "INFO" "[Restic Backup Started]"

# Pre-backup tasks
log "INFO" "[Running Pre-Backup Tasks]"
/opt/scripts/backup/before_backup.sh >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
log "INFO" "[Completed Pre-Backup Tasks]"

# Define directories to backup
DIRECTORIES="/home /etc /var/log/syslog /opt/DockerComposeFile /mnt/data/docker/compose /opt/scripts /mnt/data/docker/data/427680.427680/volumes"

# Perform backup
log "INFO" "[Starting Backup]"
restic backup -v $DIRECTORIES >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "[Completed Backup]"

# Post-backup tasks
log "INFO" "[Running Post-Backup Tasks]"
/opt/scripts/backup/after_backup.sh >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 3
log "INFO" "[Completed Post-Backup Tasks]"

# Verify backup
log "INFO" "[Verifying Backups]"
restic check >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "[Backup Verification Completed]"

# Snapshot clean up
log "INFO" "[Snapshot Cleanup Starting]"
restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune -c >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "[Snapshot Cleanup Completed]"

# Display snapshots
log "INFO" "[Displaying Snapshots]"
restic snapshots -c >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "[Completed Displaying Snapshots]"
sleep 2
# Final message
log "INFO" "[Restic Backup Completed]"

