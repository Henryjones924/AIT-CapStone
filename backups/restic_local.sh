#!/bin/bash

# Set environment variables
export RESTIC_REPOSITORY="/backup/restic"
export RESTIC_PASSWORD_FILE="/backup/.env"
LOG_FILE="/var/log/restic/restic_local.log"
DIRECTORIES="/opt/docker/compose /opt/scripts /opt/docker/*/volumes"
PREBACKUPSCRIPT="/opt/scripts/backup/restic_pre_backup.sh"
POSTBACKUPSCRIPT="/opt/scripts/backup/restic_post_backup.sh"

#Log messages
log() {
    local type="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$type] $message" >> "$LOG_FILE"
}

#Start of Logging
log "INFO" "Restic Backup Started"

#Create Log File if it does not exists
if [[ -f $LOG_FILE ]]; then
    log "INFO" "Restic log file exists"
else
    touch $LOG_FILE
    chown root:root $LOG_FILE
    chmod 600 $LOG_FILE
    log "INFO" "Restic log file created"
fi




#Pre-backup tasks
log "INFO" "Running Pre-Backup Tasks"
$PREBACKUPSCRIPT >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
log "INFO" "Completed Pre-Backup Tasks"

#backup
log "INFO" "Starting Backup"
restic backup -v $DIRECTORIES >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "Completed Backup"

# Post-backup tasks
log "INFO" "Running Post-Backup Tasks"
$POSTBACKUPSCRIPT >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 3
log "INFO" "Completed Post-Backup Tasks"

# Verify backup
log "INFO" "Verifying Backups"
restic check >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "Backup Verification Completed"

# Snapshot clean up
log "INFO" "Snapshot Cleanup Starting"
restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune -c >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "Snapshot Cleanup Completed"

# Display snapshots
log "INFO" "Displaying Snapshots"
restic snapshots -c >> >(while IFS= read -r line; do log "INFO" "$line"; done) 2> >(while IFS= read -r line; do log "ERROR" "$line"; done)
sleep 2
log "INFO" "Completed Displaying Snapshots"
sleep 2
# Final message
log "INFO" "Restic Backup Completed"

