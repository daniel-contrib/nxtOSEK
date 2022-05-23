#!/usr/bin/env bash
WORKING_DIR=$PWD
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)


echo "Usage: flash-rxe-app.sh [RXEBIN [COM]] 
  - RXEBIN is path to NXC-Firmware binary program file
      If not supplied, searches the working directory for
      a valid .rxe file, and downloads that to the NXT
  - COM is either 'usb' (default) or another valid nexttool alias
"

if (( $# == 0 )); then
  pattern="*.rxe"
  matches=( $pattern )
  RXEBIN="${matches[0]}"
  COM=usb
elif (( $# == 1 )); then
  RXEBIN=$1
  COM=usb
elif (( $# == 2 )); then
  RXEBIN=$1
  COM=$2
else
  echo "Error: wrong number of arguments"
  exit
fi

if [ ! -f "$RXEBIN" ]; then
  echo "Error: file '$RXEBIN' does not exist"
  exit
fi

FSIZE_KB=$(du -k "$RXEBIN" | cut -f1)
echo "Downloading NXC-Firmware App '$RXEBIN' ($FSIZE_KB kB) to COM=$COM..." 

"$NXT_TOOLS_DIR/nexttool" /COM=$COM -download=$RXEBIN 

echo "Listing programs on $COM..."

"$NXT_TOOLS_DIR/nexttool" /COM=$COM -listfiles 

