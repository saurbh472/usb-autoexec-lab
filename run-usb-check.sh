#!/bin/bash

# Get current username
CURRENT_USER=$(whoami)

# Log start and increase wait time
echo "---" >> /tmp/flow.log
echo "USB plugged at: $(date)" >> /tmp/flow.log
echo "Current user: $CURRENT_USER" >> /tmp/flow.log
echo "Waiting for USB to mount completely..." >> /tmp/flow.log

# Wait longer - USB mounting can take time
sleep 40

# Check all potential mount locations
for USB_PATH in "/media/$CURRENT_USER/"* "/media/"*/* "/run/media/$CURRENT_USER/"*
do
    echo "Checking path: $USB_PATH" >> /tmp/flow.log

    # Here main is script file that we want to execute
    # Check if this path exists and contains our script
    if [ -f "$USB_PATH/main.sh" ]; then
        echo "Found main.sh at $USB_PATH, executing..." >> /tmp/flow.log
        # Make sure the script is executable
        chmod +x "$USB_PATH/main.sh"
        # Run the script
        bash "$USB_PATH/main.sh" >> /tmp/flow.log 2>&1
        exit 0
    fi
done

# If we got here, we didn't find the script
echo "ERROR: main.sh not found in any USB location" >> /tmp/flow.log
ls -la "/media/$CURRENT_USER/" >> /tmp/flow.log 2>&1
