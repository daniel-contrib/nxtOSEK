#!/usr/bin/env bash
if [ -z ${NXT_TOOLS_DIR+x} ]; then
    NXT_TOOLS_DIR="/usr/local/bin"
fi
if [ -z ${NXTOSEK+x} ]; then
    NXTOSEK="/usr/local/src/nxtosek"
fi


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
  echo "Error: file \"$RXEBIN\" does not exist"
  exit
fi

FSIZE_KB=$(du -k "$RXEBIN" | cut -f1)
echo "Downloading NXC-Firmware App \"$RXEBIN\" ($FSIZE_KB kB) to COM=$COM..." 

"$NXT_TOOLS_DIR/nexttool" /COM=$COM -download="$RXEBIN"

echo "Listing programs on $COM..."

"$NXT_TOOLS_DIR/nexttool" /COM=$COM -listfiles 

