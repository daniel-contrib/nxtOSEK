#!/usr/bin/env bash
WORKING_DIR=$PWD
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Usage: flash-bios-firmware.sh [COM] 
  - COM is either 'usb' (default) or another valid nexttool alias
"

FIRMWARE="$NXTOSEK/firmware/nxt_bios_rom_3.00.rfw"
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

echo "Flashing NXT-BIOS firmware '$FIRMWARE' to COM=$COM..." 

"$NXT_TOOLS_DIR/nexttool" $NXT_TOOLS_DIR/nexttool /COM=$COM -firmware="$FIRMWARE"
