#!/bin/bash

echo "Starting configuration of USB installation..."

# Step 1: Copy systemd service file
if [ -f run-system.service ]; then
    sudo cp run-system.service /etc/systemd/system/
    echo "Copied run-system.service to /etc/systemd/system/"
else
    echo "run-system.service not found!"
fi

# Step 2: Copy run-usb-check.sh script
if [ -f run-usb-check.sh ]; then
    sudo cp run-usb-check.sh /usr/local/bin/run-usb-check.sh
    sudo chmod +x /usr/local/bin/run-usb-check.sh
    echo "Copied and made executable: /usr/local/bin/run-usb-check.sh"
else
    echo "run-usb-check.sh not found!"
fi

# Step 3: Copy udev rules
if [ -f 99-dev.rules ]; then
    sudo cp 99-dev.rules /etc/udev/rules.d/
    echo "Copied 99-dev.rules to /etc/udev/rules.d/"
else
    echo "99-dev.rules not found!"
fi

# Step 4: Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Step 5: Enable the service
echo "Enabling run-system.service..."
sudo systemctl enable run-system.service

# Step 6: Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules

# Step 7: Trigger udev
echo "Triggering udev..."
sudo udevadm trigger

echo "Installation complete. Your system is now ready!"
