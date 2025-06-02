#!/bin/bash

echo "Starting configuration USB uninstallation..."

# Step 1: Remove udev rule
if [ -f /etc/udev/rules.d/99-dev.rules ]; then
    sudo rm /etc/udev/rules.d/99-dev.rules
    echo "Deleted udev rule."
else
    echo "No udev rule found."
fi

# Step 2: Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload
sudo udevadm trigger

# Step 3: Remove helper script if it exists
if [ -f /usr/local/bin/dev-helper.sh ]; then
    sudo rm /usr/local/bin/dev-helper.sh
    echo "Deleted dev script."
fi

# Step 4: Remove systemd service
if [ -f /etc/systemd/system/run-system.service ]; then
    echo "Stopping and disabling systemd service..."
    sudo systemctl stop run-system.service
    sudo systemctl disable run-system.service
    sudo rm /etc/systemd/system/run-system.service
    echo "Deleted run-system.service file."
else
    echo "No systemd service found."
fi

# Step 5: Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Uninstallation complete. System is clean now."

