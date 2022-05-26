#!/usr/bin/env bash
WORKING_DIR=$PWD
SCRIPTS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"
CONFIG_DIR="$ROOT_DIR/config"
SRC_DIR="$ROOT_DIR/src"
VERSION=$(cat "$ROOT_DIR/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

INSTALL_DIR="/usr/local/bin"

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    git subversion gcc g++ build-essential fpc libusb-0.1-4 libusb-dev

# Download BricxCC, build NeXTTool, install
echo "Downloading repository: http://svn.code.sf.net/p/bricxcc/code/"
mkdir -p "$SRC_DIR/bricxcc"
cd "$SRC_DIR/bricxcc"
svn checkout http://svn.code.sf.net/p/bricxcc/code/

echo "Building nexttool..."
cd "$SRC_DIR/bricxcc/code"
make -f nexttool.mak
sudo cp -f "./nexttool" "$INSTALL_DIR/nexttool"

echo "Installing nexttool to $INSTALL_DIR..."
cd "$INSTALL_DIR"
sudo chown root:root "./nexttool"
sudo chmod a+s "./nexttool"

if [ ! -d "/home/$USER/bricxcc" ]; then
    cp -r "$CONFIG_DIR/bricxcc" "/home/$USER/bricxcc"
fi

# Download LibNXT, build fwflash and fwexec, install
if [ -x "$(command -v docker)" ]; then
    echo "Downloading repository: https://github.com/rvs/libnxt.git"
    cd "$SRC_DIR"
    if [ ! -d "./libnxt" ]; then
        git clone https://github.com/rvs/libnxt.git
    else
        cd "./libnxt"
        git pull origin master
    fi

    echo "Building libnxt..."
    cd "$SRC_DIR/libnxt"
    make
    sudo cp -f "./out/fwflash" "$INSTALL_DIR/fwflash"
    sudo cp -f "./out/fwexec" "$INSTALL_DIR/fwexec"
    
    echo "Installing fwexec and fwflash to $INSTALL_DIR..."
    cd "$INSTALL_DIR"
    sudo chown root:root "./fwflash"
    sudo chmod a+s "./fwflash"
    sudo chown root:root "./fwexec"
    sudo chmod a+s "./fwexec"
else
    echo "Could not install LibNXT (Docker not installed)."
fi

cd "$WORKING_DIR"

