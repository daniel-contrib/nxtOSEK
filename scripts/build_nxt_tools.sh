#!/usr/bin/env bash
WORKING_DIR="$PWD"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR/.."
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)
INSTALL_DIR="/usr/local/bin"

sudo apt-get install --no-install-recommends gcc g++ build-essential fpc libusb-0.1-4 libusb-dev scons python

# Download BricxCC, build NeXTTool, install
mkdir -p "/tmp/bricxcc"
cd "/tmp/bricxcc"
svn checkout http://svn.code.sf.net/p/bricxcc/code/
cd "/tmp/bricxcc/code"
make -f nexttool.mak
chmod +x nexttool
cp nexttool ${INSTALL_DIR}/nexttool
rm -rf "/tmp/bricxcc"


# Download LibNXT, build fwflash and fwexec, install
cd "/tmp"
git clone https://github.com/rvs/libnxt.git
cd "/tmp/libnxt"
scons
chmod +x ./fwflash
chmod +x ./fwexec
cp ./fwflash ${INSTALL_DIR}/fwflash
cp ./fwexec ${INSTALL_DIR}/fwexec
rm -rf "/tmp/libnxt"


cd "$WORKING_DIR"


echo "Script complete."
echo "Please check if nexttool, fwflash, fwexec exist in $INSTALL_DIR"
echo "and also if they work properly!"
