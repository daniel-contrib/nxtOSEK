#!/usr/bin/env bash
WORKING_DIR="$PWD"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR/.."
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

# Download the latest Docker image from github releases page
cd "$PROJECT_ROOT/docker_image"
wget -O "nxtosek-latest.tar.part-aa" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-aa" 
wget -O "nxtosek-latest.tar.part-ab" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ab" 
wget -O "nxtosek-latest.tar.part-ac" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ac" 
wget -O "nxtosek-latest.tar.part-ad" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ad" 
wget -O "nxtosek-latest.tar.part-ae" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ae" 
wget -O "nxtosek-latest.tar.part-af" "https://github.com/danielk-98/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-af" 


# Install the image
"$SCRIPT_DIR/docker-scripts/load-image.sh" nxtosek:latest

cd "$WORKING_DIR"