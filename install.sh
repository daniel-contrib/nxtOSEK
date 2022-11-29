#!/usr/bin/env bash

# ***************************************
# FUNCTIONS AND VARIABLES
# ***************************************
root_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$root_dir/scripts"
src_dir="$root_dir/src"
version=$(cat "$root_dir/VERSION")

# Import functions from other files
sources=(   "$script_dir/bash-common-scripts/common-functions.sh" 
            "$script_dir/bash-common-scripts/common-io.sh"
            "$script_dir/bash-common-scripts/common-sysconfig.sh"
            "$script_dir/bash-common-scripts/wsl-functions.sh"
            "$script_dir/installation-routines.sh"                 )
for i in "${sources[@]}"; do
    if [ ! -e "$i" ]; then
        echo "Error - could not find required source: $i"
        echo "Please run:"
        echo "  git submodule update --init --recursive --remote"
        echo ""
        exit 1
    else
        source "$i"
    fi
done


# ***************************************
# ARGS
# ***************************************
declare -a args=( [skip-all]=false )
fast_argparse args "" "skip-prompts"

if [[ "${args[skip-prompts]}" == true ]]; then
    _AUTOCONFIRM=true
fi


# ***************************************
# SCRIPT START
# ***************************************
require_non_root

# Main Menu
title="NXTOSEK $version Installation Procedure"
description="""\
The following steps are required.
Please run them in order. \
"""
unset options
unset fncalls
declare -A options
declare -A fncalls; 
options[1]="Install Prerequisites"
fncalls[1]="install_prerequisites"
options[2]="Install USBIP Service (WSL2 only)"
fncalls[2]="install_wsl_usb"
options[3]="Install Docker"
fncalls[3]="install_docker"
options[4]="Install NXTOSEK Toolchain"
fncalls[4]="install_toolchain"
options[5]="Build NXT Tools"
fncalls[5]="install_nxt_tools"
options[6]="Add Bluetooth Support (Optional)"
fncalls[6]="install_bluetooth"

function_select_menu options fncalls "$title" "$description"

