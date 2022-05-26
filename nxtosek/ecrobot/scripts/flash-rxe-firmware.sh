#!/usr/bin/env bash
if [ -z ${NXT_TOOLS_DIR+x} ]; then
    NXT_TOOLS_DIR="/usr/local/bin"
fi
if [ -z ${NXTOSEK+x} ]; then
    NXTOSEK="/usr/local/src/nxtosek"
fi
FIRMWARE="$NXTOSEK/firmware/lms_arm_nbcnxc_132_20130303_2051.rfw"

echo "Usage: flash-rxe-firmware.sh [COM] 
  - COM is either 'usb' (default) or another valid nexttool alias
"


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

echo "Flashing NXC/NBC Enhanced Firmware \"$FIRMWARE\" to COM=$COM..." 

"$NXT_TOOLS_DIR/nexttool" /COM=$COM -firmware="$FIRMWARE"
