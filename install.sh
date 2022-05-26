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

# Download latest version of WSL-USB scripts
echo "Downloading repository: https://github.com/danielk-98/wsl-usb-scripts.git"
if [ ! -d "$SCRIPTS_DIR/wsl-usb-scripts" ]; then
    cd "$SCRIPTS_DIR"
    git clone https://github.com/danielk-98/wsl-usb-scripts.git
else
    cd "$SCRIPTS_DIR/wsl-usb-scripts"
    git pull origin main
fi
cd "$SCRIPTS_DIR/wsl-usb-scripts"
chmod +x *.sh

# Download latest version of Docker scripts
echo "Downloading repository: https://github.com/danielk-98/docker-scripts.git"
if [ ! -d "$SCRIPTS_DIR/docker-scripts" ]; then
    cd "$SCRIPTS_DIR"
    git clone https://github.com/danielk-98/docker-scripts.git
else
    cd "$SCRIPTS_DIR/docker-scripts"
    git pull origin main
fi
cd "$SCRIPTS_DIR/docker-scripts"
chmod +x *.sh

# UDEV
echo
echo "${bold}UDEV${normal}"
echo
echo "UDEV rules are required to access NXT/SAM-BA devices over USB."
echo "Without this, NXT tools will not work without 'sudo' and USB-passthrough to Docker will not be available."
read -r -p "${bold}Install UDEV rules? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
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
fi

# WSL only: Install USB-IP services for Linux
if [ $WSL == 'true' ]; then
    echo
    echo "${bold}USB-IP${normal}"
    echo
    echo "WSL2 requires USB-over-IP to connect to the host machine's USB devices."
    echo "Make sure you also have the latest release of USBIPD Server installed on Windows as well: "
    echo "https://github.com/dorssel/usbipd-win/releases/"
    read -r -p "${bold}Install USB-IP Services? (Y/N): ${normal} " 
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    
        if [ ! -f "/etc/default/usbip-automount" ]; then
            echo "Installing USB-IP for WSL..."
            cd "$SCRIPTS_DIR/wsl-usb-scripts"
            "./install.sh"
        else
            echo "It appears wsl-usb-scripts has already been installed. Skipping..."
        fi

        echo "Setting NXT devices to autoattach to WSL"
        APPEND='DEVICE_MATCH_SUBSTRINGS=$(echo -e "$DEVICE_MATCH_SUBSTRINGS\n0694:0002\n03eb:6124")'
        FILE="/etc/default/usbip-automount"
        sudo grep -qxF "$APPEND" "$FILE" || echo "$APPEND" | sudo tee -a "$FILE" > /dev/null

        service usbip-automount stop
        sleep 2
        service usbip-automount start
    fi
fi

# Add bluetooth support
echo
echo "${bold}Bluetooth${normal}"
echo
read -r -p "${bold}Install Bluetooth services? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    sudo apt-get install -y --no-install-recommends \
        bluez bluetooth
fi

# Install Docker
echo
echo "${bold}Docker${normal}"
echo
echo "Docker is required to use the nxtOSEK Docker Image."
echo "Docker is also required to compile LibNXT, without which some nxtOSEK tools will not function."
echo "If not installed, "
echo "all toolchain components (Wine, ARM cross-compiler, etc. will need to be installed on your system."
read -r -p "${bold}Install Docker? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ ! -x "$(command -v docker)" ]; then
        echo "Docker not detected. Installing now..."
        cd "$SCRIPTS_DIR/docker-scripts"
        "./install-docker.sh"
    else
        echo "It appears Docker has already been installed. Skipping..."
    fi

    # This setting is required for Wine to run within Docker
    echo "Setting SYSCTL parameters..."
    sudo sysctl -w vm.mmap_min_addr=0
fi

# NXT Tools (Local Install)
echo
echo "${bold}NXT Tools (Local Install)${normal}"
echo
echo "This will download, build, and install to /usr/local/bin: "
echo " 1. John Hansen's NeXTTool (1.2.1.r5) from BricxCC 3.0"
echo "    - Required for downloading .rxe binaries to the NXT"
echo "    - Required for downloading .rfw firmware to the NXT"
echo " 2. Roman Shaposhnik's LibNXT (0.3) (requires Docker)"
echo "    - Optional for downloading .rfw firmware to the NXT"
echo "    - Required for rambooting programs on the NXT"
echo "If not installed, they can still be used within the Docker image."
read -r -p "${bold}Install NXT Tools? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    "./install_nxt_tools.sh"
fi


# nxtOSEK Toolchain (Local Install)
echo
echo "${bold}nxtOSEK Toolchain (Local Install)${normal}"
echo "This is the recommended way to use nxtOSEK."
echo "Will download and install the following software required for nxtOSEK: "
echo " 1. ARM-None-EABI (ARM cross compiler)"
echo " 1. GDB, OpenOCD, FTDI-support (real-time debugging utilities)"
echo " 2. Wine-stable (required during linking process)"
echo " 3. nxtOSEK development files (installs to $NXTOSEK)"
echo "If not installed, you can choose to install the Docker image instead."
read -r -p "${bold}Install nxtOSEK? (Y/N): ${normal} " 
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$SCRIPTS_DIR"
    "./install_toolchain.sh"
fi

# nxtOSEK Docker Image
if [ -x "$(command -v docker)" ]; then
    echo
    echo "${bold}nxtOSEK Docker Image${normal}"
    echo
    echo "This downloads a precompiled image containing a complete nxtOSEK development environment and all required NXT tools."
    echo "This may take some time."
    read -r -p "${bold}Install nxtOSEK Docker Image? (Y/N): ${normal} " 
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$SCRIPTS_DIR"
        "./download_release.sh"
    fi
else
    echo
    echo "Skipping option to download nxtOSEK Docker Image."
    echo " (Docker not installed.)"
fi

cd "$WORKING_DIR"

echo "nxtOSEK Installer is complete."
echo "Please restart your machine before continuing."

