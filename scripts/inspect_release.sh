#!/usr/bin/env bash
WORKING_DIR="$PWD"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR/.."
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)


docker run --rm -it --privileged --entrypoint bash nxtosek:latest
#docker run --rm -it -v /dev/bus/usb:/dev/bus/usb -v /run/udev:/run/udev:ro --device=/dev/bus/usb --entrypoint bash nxtosek:latest
#docker run --rm -it -v /dev/bus/usb:/dev/bus/usb -v /run/udev:/run/udev:ro --entrypoint bash nxtosek:latest
