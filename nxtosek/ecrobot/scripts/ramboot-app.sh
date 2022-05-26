#!/usr/bin/env bash
if [ -z ${NXT_TOOLS_DIR+x} ]; then
    NXT_TOOLS_DIR="/usr/local/bin"
fi
if [ -z ${NXTOSEK+x} ]; then
    NXTOSEK="/usr/local/src/nxtosek"
fi

echo "Usage: ramboot-app.sh [RAMBIN [COM]] 
  - RAMBIN is path to NXT-BIOS binary program file
      If not supplied, searches the working directory for
      a valid .bin file, and downloads that to the NXT
  - COM is either 'usb' (default) or another valid nexttool alias
"

if (( $# == 0 )); then
  pattern="*_ram.bin"
  matches=( $pattern )
  RAMBIN="${matches[0]}"
  COM=usb
elif (( $# == 1 )); then
  RAMBIN=$1
  COM=usb
elif (( $# == 2 )); then
  RAMBIN=$1
  COM=$2
else
  echo "Error: wrong number of arguments"
  exit
fi

if [ ! -f "$RAMBIN" ]; then
  echo "Error: file '$RAMBIN' does not exist"
  exit
fi

FSIZE_KB=$(du -k "$RAMBIN" | cut -f1)
echo "Executing '$RAMBIN' ($FSIZE_KB kB) from RAM on COM=$COM..." 

"$NXT_TOOLS_DIR/fwexec" "./$RAMBIN"
