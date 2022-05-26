#!/usr/bin/env bash
WORKING_DIR=$PWD
ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIG_DIR="$ROOT_DIR/config"
SCRIPTS_DIR="$ROOT_DIR/scripts"
SRC_DIR="$ROOT_DIR/src"
VERSION=$(cat "$ROOT_DIR/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)
if [ -z ${NXTOSEK+x} ]; then
    export NXTOSEK="/usr/local/src/nxtosek"
fi

# Prerequisites
sudo apt-get update
sudo apt-get install wget curl git
cd "$SCRIPTS_DIR"
chmod +x *.sh

# UDEV controlls access to hardware devices.
# Better user experience if users have full access to NXTs by default
# Required for access to NXT devices over USB
echo "Adding UDEV rules for NXT devices..."
sudo groupadd -f plugdev
sudo groupadd -f dialout
sudo groupadd -f users
sudo usermod -aG plugdev $USER
sudo usermod -aG dialout $USER
sudo usermod -aG users $USER
cd "$CONFIG_DIR/udev"
sudo cp -f "./70-nxt.rules" "/etc/udev/rules.d/70-nxt.rules"
sudo cp -f "./nxt_event_handler.sh" "/etc/udev/nxt_event_handler.sh" && sudo chmod +x "/etc/udev/nxt_event_handler.sh"
sudo udevadm control --reload-rules && sudo udevadm trigger

# WSL only: Install USB-IP services for Linux
if [ $WSL == 'true' ]; then
    echo "WSL2 detected."
    
    echo "Downloading repository: https://github.com/danielk-98/wsl-usb-scripts.git"
    if [ ! -d "$SCRIPTS_DIR/wsl-usb-scripts" ]; then
        cd "$SCRIPTS_DIR"
        git clone https://github.com/danielk-98/wsl-usb-scripts.git
    else
        cd "$SCRIPTS_DIR/wsl-usb-scripts"
        git pull origin main
    fi

    if [ ! -f "/etc/default/usbip-automount" ]; then
        echo "Installing USB-IP for WSL..."
        cd "$SCRIPTS_DIR/wsl-usb-scripts"
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

# Download Docker scripts
echo "Downloading repository: https://github.com/danielk-98/docker-scripts.git"
if [ ! -d "$SCRIPTS_DIR/docker-scripts" ]; then
    cd "$SCRIPTS_DIR"
    git clone https://github.com/danielk-98/docker-scripts.git
else
    cd "$SCRIPTS_DIR/docker-scripts"
    git pull origin main
fi

# Install Docker
echo
echo "${bold}Docker${normal}"
echo "Docker is optional (nxtOSEK can be installed locally instead) but without Docker all toolchain components (Wine, ARM cross-compiler, etc. will need to be installed on your system."
echo "Docker is also required to compile LibNXT, without which some nxtOSEK tools will not function."
read -r -p "${bold}Install Docker? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ ! -x "$(command -v docker)" ]; then
        echo "Docker not detected. Installing now..."
        cd "$SCRIPTS_DIR/docker-scripts"
        chmod +x *.sh
        "./install-docker.sh"
    else
        echo "It appears Docker has already been installed. Skipping..."
    fi

    # This setting is required for Wine to run within Docker
    echo "Setting SYSCTL parameters..."
    sudo sysctl -w vm.mmap_min_addr=0
fi

# NXT Tools
echo
echo "${bold}NXT Tools${normal}"
echo "This will download, build, and install to /usr/local/bin: "
echo " 1. John Hansen's NeXTTool (1.2.1.r5) from BricxCC 3.0"
echo " 2. Roman Shaposhnik's LibNXT (0.3) (requires Docker)"
read -r -p "${bold}Install NXT Tools? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    "./install_nxt_tools.sh"
fi

# Add bluetooth support
echo
echo "${bold}Bluetooth${normal}"
read -r -p "${bold}Install Bluetooth services? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    sudo apt-get install -y --no-install-recommends \
        bluez bluetooth
fi

# NXTOSEK and Toolchain
echo
echo "${bold}nxtOSEK Toolchain${normal}"
echo "This will download and install the following software required for nxtOSEK: "
echo " 1. ARM-NONE-EABI (ARM cross compiler)"
echo " 2. Bluetooth services (bluez)"
echo " 3. Wine-stable (required during linking process)"
echo " 4. nxtOSEK development environment (installs to $NXTOSEK)"
echo "If not installed, you can choose to install the Docker image instead."
read -r -p "${bold}Install nxtOSEK? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    "./install_toolchain.sh"
fi

echo
echo "${bold}nxtOSEK Docker Image${normal}"
echo "This downloads a precompiled image containing a complete nxtOSEK development environment."
echo "This may take some time."
read -r -p "${bold}Install nxtOSEK Docker Image? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    "./download_release.sh"
fi

cd "$WORKING_DIR"

echo "nxtOSEK Installer is complete."
echo "Please restart your machine before continuing."

