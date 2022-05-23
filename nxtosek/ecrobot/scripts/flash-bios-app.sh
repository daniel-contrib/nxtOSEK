#!/usr/bin/env bash
WORKING_DIR=$PWD
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)


echo "Usage: flash-bios-app.sh [ROMBIN [COM]] 
  - ROMBIN is path to NXT-BIOS binary program file
      If not supplied, searches the working directory for
      a valid .bin file, and downloads that to the NXT
  - COM is either 'usb' (default) or another valid nexttool alias
"

if (( $# == 0 )); then
  pattern="*_rom.bin"
  matches=( $pattern )
  ROMBIN="${matches[0]}"
  COM=usb
elif (( $# == 1 )); then
  ROMBIN=$1
  COM=usb
elif (( $# == 2 )); then
  ROMBIN=$1
  COM=$2
else
  echo "Error: wrong number of arguments"
  exit
fi

if [ ! -f "$ROMBIN" ]; then
  echo "Error: file '$ROMBIN' does not exist"
  exit
fi

FSIZE_KB=$(du -k "$ROMBIN" | cut -f1)
echo "Downloading NXT-BIOS App '$ROMBIN' ($FSIZE_KB kB) to COM=$COM..." 

"$NXT_TOOLS_DIR/appflash" ./$ROMBIN
