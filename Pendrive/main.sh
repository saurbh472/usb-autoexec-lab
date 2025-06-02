#!/bin/bash

set -e

START_TIME=$(date +%s)
LOGFILE="/tmp/flow.log"

# Helper function for logging with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# Get the real username even when running as root or via sudo
get_real_username() {
    # Try SUDO_USER first (for sudo execution)
    if [ -n "$SUDO_USER" ]; then
        echo "$SUDO_USER"
        return
    fi
    
    # Try to find the currently logged in X user
    local x_user=$(who | grep -m1 '(:0|tty7|tty1)' | awk '{print $1}')
    if [ -n "$x_user" ]; then
        echo "$x_user"
        return
    fi
    
    # Try logname command
    if command -v logname >/dev/null 2>&1; then
        local logname_user=$(logname 2>/dev/null)
        if [ -n "$logname_user" ] && [ "$logname_user" != "root" ]; then
            echo "$logname_user"
            return
        fi
    fi
    
    # Try to find non-root users with active sessions using loginctl
    if command -v loginctl >/dev/null 2>&1; then
        local logged_users=$(loginctl list-users | grep -v "UID" | awk '{print $2}' | grep -v "^$")
        for user in $logged_users; do
            if [ "$user" != "root" ]; then
                echo "$user"
                return
            fi
        done
    fi
    
    # If nothing else works, return current user
    whoami
}

# Set current user
CURRENT_USER=$(get_real_username)

log "USB plugged in. Starting process..."
log "Current user: $CURRENT_USER"
log "Waiting for USB to mount completely..."

sleep 25

FOUND_USB=0

for USB_PATH in /media/$CURRENT_USER/* /media/*/* /run/media/$CURRENT_USER/*
do
    if [ -d "$USB_PATH/Installation" ]; then
        log "Found Installation folder on USB: $USB_PATH/Installation"
        
       

# Final timing log
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

log "--------------------------------"
log "Total time taken: $TOTAL_TIME seconds"
log "USB automation process finished at: $(date)"
log "--------------------------------"



# Reboot the system to apply changes
echo "$PASSWORD" | sudo -S reboot
