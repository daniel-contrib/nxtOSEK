#!/usr/bin/env bash
WORKING_DIR=$PWD
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

echo "Usage: flash-rxe-firmware.sh [COM] 
  - COM is either 'usb' (default) or another valid nexttool alias
"

FIRMWARE="$NXTOSEK/firmware/lms_arm_nbcnxc_132_20130303_2051.rfw"
if (( $# == 0 )); then
  COM=usb
elif (( $# == 1 )); then
  COM=$1
else
  echo "Error: wrong number of arguments"
  exit
fi

if [ ! -f "$FIRMWARE" ]; then
  echo "Error: file '$FIRMWARE' does not exist"
  exit
fi

echo "Flashing NXC/NBC Enhanced Firmware '$FIRMWARE' to COM=$COM..." 

"$NXT_TOOLS_DIR/nexttool" $NXT_TOOLS_DIR/nexttool /COM=$COM -firmware="$FIRMWARE"
