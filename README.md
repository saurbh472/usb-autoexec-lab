# USB AutoExec Lab Tool

> ⚠️ **Ethical Use Notice**: This project is intended **for educational, controlled lab environments only**. Do **not** use this tool to execute arbitrary code on machines without the owner's full, informed consent. Misuse of this code can be illegal and unethical.

## Description

This project sets up a Linux system to automatically execute a script from a USB device whenever it is inserted. It leverages `udev` rules and shell scripts for automated behavior, simulating a USB autorun feature for lab or pentest simulation environments.

## How It Works

- A script `install_sensai.sh` installs required files and configures the system.
- A `udev` rule (`99-dev.rules`) is placed in `/etc/udev/rules.d/` to monitor for specific USB devices.
- When the specified USB is inserted, the system will run the main autorun script from the USB drive.
- This simulates USB autorun behavior which can be used for red-team training or automation.

## ⚙️ Installation Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/usb-autoexec-lab.git
   cd usb-autoexec-lab

2. Identify Your USB Info
Insert your USB and run:
lsusb

Find the line with your USB and note:
ID_VENDOR_ID
ID_MODEL_ID
Edit the 99-dev.rules file to match your device.

3. Run the Installer
bash
Copy
Edit
chmod +x install_sensai.sh
sudo ./install_sensai.sh
This will:
Copy necessary scripts to target directories (e.g., /home)
Move the udev rule to /etc/udev/rules.d/
Reload udev rules

📦 Files
File	Purpose
install_sensai.sh	Installs udev rule and copies scripts
99-dev.rules	Custom udev rule to detect specific USB device
autorun.sh	Example payload script on USB (user-defined)

🧪 How to Use
Format your USB and copy a script named autorun.sh onto it.
Make sure it has execution permissions:
bash
Copy
Edit
chmod +x /path/to/usb/autorun.sh
Plug it into the configured Linux system.
If set up properly, udev will detect it and execute the script automatically.

🛑 Important Notes
Only works if user has root permissions to modify udev rules.
Most Linux distros don’t allow autorun by default for security reasons.
Always test in a virtual machine or safe lab environment.
This is not a hacking tool. It is for training and awareness.

🔐 Disclaimer
This project is intended for educational purposes only.
The authors and contributors are not responsible for any misuse.
Always obtain full permission before using this in any environment that is not your own.
