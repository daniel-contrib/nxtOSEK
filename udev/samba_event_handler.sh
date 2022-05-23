#!/usr/bin/env bash

SERIAL=$1
KERNEL=$2
MAJOR=$3
MINOR=$4
CONTAINER_IDS=$(docker ps -qf ancestor=nxtosek -f status=running)

LOGFILE_DIR="/tmp/nxt"
LOGFILE="samba-events.log"

mkdir -p "$LOGFILE_DIR"
echo "USB Event: 
  ACTION:   $ACTION
  DEVTYPE:  $DEVTYPE
  KERNEL:   $KERNEL
  SERIAL:   $SERIAL
  DEVNUM:   $DEVNUM
  DEVNAME:  $DEVNAME
  DEVLINKS: $DEVLINKS
  DEVPATH:  $DEVPATH
  MAJOR:    $MAJOR
  MINOR:    $MINOR
  Docker Containers: $CONTAINER_IDS
" >> "$LOGFILE_DIR/$LOGFILE"

if [ $ACTION == "add" ]; then
  IFS=$'\n'
  CONTAINER_IDS=($CONTAINER_IDS)
  for CONTAINER in ${CONTAINER_IDS[@]}; do
    docker exec -u 0 $CONTAINER mknod $DEVNAME c $MAJOR $MINOR
    docker exec -u 0 $CONTAINER chmod -R 777 $DEVNAME
  done
fi
