#!/usr/bin/env bash
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"
CONFIG_DIR="$ROOT_DIR/config"
SRC_DIR="$ROOT_DIR/src"
VERSION=$(cat "$ROOT_DIR/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

sudo apt-get update

# Packages required to install more packages
sudo apt-get -y install --no-install-recommends \
    wget gnupg software-properties-common

# Install ARM cross-compiler
sudo apt-get -y install --install-recommends \
    make gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib 

# Install JTAG debugger support
sudo apt-get -y install --no-install-recommends \
    usbutils gdb-multiarch openocd libusb-0.1-4 libusb-dev libftdi1 libftdi-dev

# Install wine-headless script
chmod +x "$SCRIPTS_DIR/wine-headless.sh"
sudo cp -f "$SCRIPTS_DIR/wine-headless.sh" "/usr/local/bin/wine-headless"

# Install wine and Xvfb virtual frame buffer (required for wine-headless)
if [ ! -x "$(command -v wine)" ]; then
    echo "Installing Wine..."
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    rm winehq.key
    sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu
    sudo apt-get update
    sudo apt-get -y --no-install-recommends install xvfb winehq-stable

    # Initialize a wine install
    export WINEDLLOVERRIDES="mscoree,mshtml="
    wine-headless wineboot
else
    echo "It appears Wine is already installed, skipping..."
fi

# Install nxtOSEK core files
if [ -z ${NXTOSEK+x} ]; then
    NXTOSEK="/usr/local/src/nxtosek"
fi
INSTALL_DIR="$(dirname "$NXTOSEK")"

echo "Installing nxtOSEK to $NXTOSEK..."
sudo rm -rf "$NXTOSEK"
sudo mkdir -p "$INSTALL_DIR"
sudo cp -rf "$ROOT_DIR/nxtosek" "$INSTALL_DIR"
