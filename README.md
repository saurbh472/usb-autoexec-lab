# USB AutoExec Lab Tool

> ⚠️ **Ethical Use Notice**: This project is intended **for educational, controlled lab environments only**. Do **not** use this tool to execute arbitrary code on machines without the owner's full, informed consent. Misuse of this code can be illegal and unethical.

## Description

This project sets up a Linux system to automatically execute a script from a USB device whenever it is inserted. It leverages `udev` rules and shell scripts for automated behavior, simulating a USB autorun feature for lab or pentest simulation environments.

  ## 🧱 Project Structure
  usb-autoexec-lab/
├── install_sensai.sh # Installer: Sets up udev rule & config
├── uninstall_Configuration.sh # Uninstaller: Cleans up and resets the system
├── 99-dev.rules # udev rule to detect specific USB and trigger action
├── run-usb-check.sh # Script triggered by udev when USB is inserted
├── run-system.service # Optional: systemd service (if needed for persistence)
├── README.md # This documentation
├── Permission files.txt # [Describe what this is or remove if unused]
└── Pendrive/
└── main.sh # The autorun script that lives on the USB


## 💡 How It Works

1. You install `udev` rules that detect a specific USB device.
2. When that USB is inserted, the rule triggers a system script (`run-usb-check.sh`).
3. That script looks for and executes `main.sh` from the USB device.
4. Once done, you can uninstall everything to restore the system to normal.
   

## ⚙️ Installation Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/usb-autoexec-lab.git
   cd usb-autoexec-lab
   

2. Identify Your USB Info
Insert your USB and run:
  ```bash
   lsusb
  ```
Find the line with your USB and note:
- ID_VENDOR_ID
- ID_MODEL_ID

Edit the 99-dev.rules file to match your device.

3. Run the Installer
   ```bash
    chmod +x install_sensai.sh
    sudo ./install_sensai.sh
    ```
This will:
Copy necessary scripts to target directories (e.g., /home)
Move the udev rule to /etc/udev/rules.d/
Reload udev rules

📦 Files
File	Purpose
- install_sensai.sh	Installs udev rule and copies scripts
- 99-dev.rules	Custom udev rule to detect specific USB device
- autorun.sh	Example payload script on USB (user-defined)


### 📁 USB Preparation

You must prepare the USB device with your autorun script:

1. **Format the USB** as `FAT32` or `ext4`.
2. **Copy** `main.sh` (your payload or automation script) to the **root directory** of the USB.
3. **Make the script executable** by running:

    ```bash
    chmod +x /media/your-usb/main.sh
    ```

> The `udev` rule will detect your USB and automatically execute `main.sh` when it is inserted.


🧪 How to Use
Format your USB and copy a script named autorun.sh onto it.
Make sure it has execution permissions:
```bash
chmod +x /path/to/usb/autorun.sh
```
Plug it into the configured Linux system.
If set up properly, udev will detect it and execute the script automatically.

🛑 Important Notes
- Only works if user has root permissions to modify udev rules.
- Most Linux distros don’t allow autorun by default for security reasons.
- Always test in a virtual machine or safe lab environment.
- This is not a hacking tool. It is for training and awareness.

🔐 Disclaimer
- This project is intended for educational purposes only.
- The authors and contributors are not responsible for any misuse.
- Always obtain full permission before using this in any environment that is not your own.
