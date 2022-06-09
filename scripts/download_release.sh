#!/usr/bin/env bash
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"
CONFIG_DIR="$ROOT_DIR/config"
SRC_DIR="$ROOT_DIR/src"
VERSION=$(cat "$ROOT_DIR/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

# Download the latest Docker image from github releases page
cd "$ROOT_DIR/docker_image"
rm "nxtosek-latest.tar.part-*"
wget -O "nxtosek-latest.tar.part-aa" "https://github.com/daniel-contrib/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-aa" 
wget -O "nxtosek-latest.tar.part-ab" "https://github.com/daniel-contrib/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ab" 
wget -O "nxtosek-latest.tar.part-ac" "https://github.com/daniel-contrib/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ac" 
wget -O "nxtosek-latest.tar.part-ad" "https://github.com/daniel-contrib/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ad" 
wget -O "nxtosek-latest.tar.part-ae" "https://github.com/daniel-contrib/nxtOSEK/releases/download/v$VERSION/nxtosek-latest.tar.part-ae" 


# Install the image
"$SCRIPTS_DIR/docker-scripts/load-image.sh" nxtosek:latest
