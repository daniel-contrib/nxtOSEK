#!/usr/bin/env bash
WORKING_DIR="$PWD"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR/.."
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)


# Download LibNXT
cd "$PROJECT_ROOT/src"
if [ ! -d "./libnxt" ]; then
    git clone https://github.com/rvs/libnxt.git
else
    git pull origin master
fi
#tar -cvf libnxt.tar "libnxt"

# Download BricxCC
mkdir -p "$PROJECT_ROOT/src/bricxcc"
cd "$PROJECT_ROOT/src/bricxcc"
svn checkout http://svn.code.sf.net/p/bricxcc/code/
#cd "$PROJECT_ROOT/src"
#tar -cvf bricxcc.tar "bricxcc"

# Build and save docker image
cd "$PROJECT_ROOT/docker_image"
"$SCRIPT_DIR/docker-scripts/build-image-fresh.sh" nxtosek:latest
"$SCRIPT_DIR/docker-scripts/save-image.sh" nxtosek:latest 1G


cd "$WORKING_DIR"