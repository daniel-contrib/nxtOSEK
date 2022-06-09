#!/usr/bin/env bash
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
ROOT_DIR="$(dirname "$SCRIPTS_DIR")"
CONFIG_DIR="$ROOT_DIR/config"
SRC_DIR="$ROOT_DIR/src"
VERSION=$(cat "$ROOT_DIR/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

# Build the NXT tools locally first
echo "Building NXT tools..."
cd "$SCRIPTS_DIR"
"./install_nxt_tools.sh"

# Build and save docker image
echo "Building Docker image..."
cd "$ROOT_DIR"
#"$SCRIPTS_DIR/docker-scripts/build-image-fresh.sh" nxtosek:latest

echo "Saving Docker image to $ROOT_DIR/docker_image..."
rm -rf "$ROOT_DIR/docker_image"
mkdir -p "$ROOT_DIR/docker_image"
cd "$ROOT_DIR/docker_image"
"$SCRIPTS_DIR/docker-scripts/save-image.sh" nxtosek:latest 1G
