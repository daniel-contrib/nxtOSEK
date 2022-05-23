#!/usr/bin/env bash
WORKING_DIR="$PWD"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR/.."
VERSION=$(cat "$PROJECT_ROOT/VERSION")
WSL=$(if grep -q microsoft /proc/version; then echo 'true'; else echo 'false'; fi)

# Download and install the latest Docker image
cd "$PROJECT_ROOT/docker_image"



cd "$WORKING_DIR"