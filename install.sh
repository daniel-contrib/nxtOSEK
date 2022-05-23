#!/usr/bin/env bash
WORKING_DIR=$PWD
PROJECT_ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR="$PROJECT_ROOT/scripts"
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)
cd "$PROJECT_ROOT"

# Prerequisites
sudo apt-get update
sudo apt-get install wget curl git subversion
cd "$SCRIPT_DIR"
chmod +x *.sh

# Install Docker
echo "Downloading Github repo: danielk-98/docker-scripts"
if [ ! -d "$SCRIPT_DIR/docker-scripts" ]; then
    cd "$SCRIPT_DIR"
    git clone https://github.com/danielk-98/docker-scripts.git
else
    cd "$SCRIPT_DIR/docker-scripts"
    git pull origin main
fi

if [ ! -x "$(command -v docker)" ]; then
    echo "Docker not detected. Installing now..."
    cd "$SCRIPT_DIR/docker-scripts"
    chmod +x *.sh
    "./install-docker.sh"
else
    echo "It appears Docker has already been installed. Skipping..."
fi

# Setting required for Wine to run within Docker
# (Wine is needed for OSEK sg.exe during the linking process)
# Technically, wine isn't needed at all on WSL because sg.exe can run natively...
# But the image contains wine anyway so we're gonna use it for this one thing
echo "Setting SYSCTL parameters..."
sudo sysctl -w vm.mmap_min_addr=0

# UDEV controlls access to hardware devices.
# Better user experience if users have full access to NXTs by default
# Required for access to NXT devices over USB
echo "Adding UDEV rules for NXT devices..."
cd "$PROJECT_ROOT/udev"
sudo groupadd -f plugdev
sudo groupadd -f dialout
sudo usermod -aG plugdev $USER
sudo usermod -aG dialout $USER
sudo cp -f "70-nxt.rules" "/etc/udev/rules.d/70-nxt.rules"
sudo cp -f "nxt_event_handler.sh" "/etc/udev/nxt_event_handler.sh" && sudo chmod +x "/etc/udev/nxt_event_handler.sh"
sudo cp -f "samba_event_handler.sh" "/etc/udev/samba_event_handler.sh" && sudo chmod +x "/etc/udev/samba_event_handler.sh"
sudo udevadm control --reload-rules && sudo udevadm trigger

# WSL only: Install USB-IP services for Linux
if [ $WSL == 'true' ]; then
    echo "WSL2 detected."
    
    echo "Downloading Github repo: danielk-98/wsl-usb-scripts"
    if [ ! -d "$SCRIPT_DIR/wsl-usb-scripts" ]; then
        cd "$SCRIPT_DIR"
        git clone https://github.com/danielk-98/wsl-usb-scripts.git
    else
        cd "$SCRIPT_DIR/wsl-usb-scripts"
        git pull origin main
    fi

    if [ ! -f "/etc/default/usbip-automount" ]; then
        echo "Installing USB-IP for WSL..."
        cd "$SCRIPT_DIR/wsl-usb-scripts"
        chmod +x *.sh
        "./install.sh"
    else
        echo "It appears wsl-usb-scripts has already been installed. Skipping..."
    fi

    echo "Setting NXT devices to autoattach to WSL"
    service usbip-automount stop
    sleep 1

    APPEND='DEVICE_MATCH_SUBSTRINGS=$(echo -e "$DEVICE_MATCH_SUBSTRINGS\n0694:0002\n03eb:6124")'
    FILE="/etc/default/usbip-automount"
    sudo grep -qxF "$APPEND" "$FILE" || echo "$APPEND" | sudo tee -a "$FILE" > /dev/null

    service usbip-automount start
fi

cd "$WORKING_DIR"

echo " "
echo "Linux Host configuration for nxtOSEK complete!"
echo "Please restart your system now before continuing."
echo " "

