
# PREREQUISITES
function install_prerequisites() {
    local -a packages=(
        wget curl unzip git gnupg software-properties-common python3 vim
    )
    echo ""
    echo "The following APT packages will be installed:" 
    echo "  ${packages[@]}"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y ${packages[@]}
}


# WSL-USB
function install_wsl_usb() {
    if ! is_wsl; then
        echo "This option is only available on WSL2."
        return
    fi
    local url="https://github.com/daniel-utilities/wsl-usb-scripts.git"
    local branch=main
    local name="$(basename $url)"; name="${name%.*}"
    local tmp_dir="/tmp"
    local repo_dir="$tmp_dir/$name"
    local install_cmd="install.sh --skip-prompts true"
    local original_dir="$pwd"
    echo ""
    echo "WSL2 does not come with USB pass through by default."
    echo "An additional service (usbipd) is needed on both Windows and WSL"
    echo "to connect USB devices automatically."
    echo ""
    echo "The following repository will be downloaded into $repo_dir:" 
    echo "  URL=$url"
    echo "  BRANCH=$branch"
    echo ""
    echo "Then, the following script will be run:"
    echo "  $install_cmd"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Downloading repository: $name"
    cd "$tmp_dir"
    git_latest "$url" "$branch"
    cd "$repo_dir"

    echo "Running command: $install_cmd"
    bash "./$install_cmd"
    cd "$original_dir"

    rm -rf "$repo_dir"
}


# DOCKER
function install_docker() {
    if [ -x "$(command -v docker)" ]; then
        echo "Docker is already installed."
        if [[ _AUTOCONFIRM == true ]]; then return; fi;
        if ! confirmation_prompt; then return; fi;
    fi
    local url="https://github.com/daniel-utilities/docker-scripts.git"
    local branch=main
    local name="$(basename $url)"; name="${name%.*}"
    local tmp_dir="/tmp"
    local repo_dir="$tmp_dir/$name"
    local install_cmd="install.sh --skip-prompts true"
    local original_dir="$pwd"
    echo ""
    echo "The following repository will be downloaded into $repo_dir:" 
    echo "  URL=$url"
    echo "  BRANCH=$branch"
    echo ""
    echo "Then, the following script will be run:"
    echo "  $install_cmd"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Downloading repository: $name"
    cd "$tmp_dir"
    git_latest "$url" "$branch"
    cd "$repo_dir"

    echo "Running command: $install_cmd"
    bash "./$install_cmd"
    cd "$original_dir"

    # This setting is required for Wine to run within Docker
    echo "Setting SYSCTL parameters..."
    sudo sysctl -w vm.mmap_min_addr=0

    rm -rf "$repo_dir"
}


# NXTOSEK
function install_toolchain() {
    local nxtosek_src="$root_dir/nxtosek"
    local install_dir="/usr/local/src"
    local -a install_files=(
        "$script_dir/wine_headless.sh : /usr/local/bin/wine_headless"
    )
    local -a compiler_packages=(     # Install ARM cross-compiler
        make gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib 
    )
    local -a debugger_packages=(     # Install JTAG debugger support
        usbutils gdb-multiarch openocd libusb-0.1-4 libusb-dev libftdi1 libftdi-dev
    )
    local -a wine_packages=(
        xvfb winehq-stable
    )
    echo ""
    echo "The NXTOSEK Toolchain consists of the following components:"
    echo " 1. nxtOSEK development files (installs to $install_dir/nxtosek)"
    echo " 2. ARM-None-EABI (ARM cross compiler)"
    echo " 3. C Standard Library for ARM (newlib)"
    echo " 4. GDB, OpenOCD, FTDI-support (real-time debugging utilities)"
    echo " 5. Wine-stable (required during linking process)"
    echo ""
    echo "The following APT packages will be installed:" 
    echo "  ${compiler_packages[@]} ${debugger_packages[@]} ${wine_packages[@}]}"
    echo "The following files will be installed:" 
    print_arr install_files
    echo "The following folder will be created:"
    echo "  $install_dir"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Copying files..."
    multicopy install_files

    echo "Installing nxtOSEK to $install_dir..."
    sudo rm -rf "$install_dir/nxtosek"
    sudo cp -rf "$nxtosek_src" "$install_dir"

    echo "Installing ARM cross-compiler and debugger..."
    sudo apt-get update
    sudo apt-get -y install --install-recommends ${compiler_packages[@]}
    sudo apt-get -y install --no-install-recommends ${debugger_packages[@]}

    echo "Installing Wine..."
    if [ -x "$(command -v wine)" ]; then
        echo "Wine is already installed."
        if [[ _AUTOCONFIRM == true ]]; then return; fi;
        if ! confirmation_prompt; then return; fi;
    fi
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
    rm winehq.key
    sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu
    sudo apt-get update
    sudo apt-get -y --no-install-recommends install ${packages[@]}

    echo "Initializing Wine..."
    export WINEDLLOVERRIDES="mscoree,mshtml="
    wine-headless wineboot
}


# NXT TOOLS
function install_nxt_tools() {
    local url="https://github.com/daniel-utilities/mindstorms-scripts.git"
    local branch=main
    local name="$(basename $url)"; name="${name%.*}"
    local tmp_dir="/tmp"
    local repo_dir="$tmp_dir/$name"
    local install_cmd="install_nxt_tools.sh --skip-prompts true"
    local original_dir="$pwd"
    echo ""
    echo "This will download, build, and install to /usr/local/bin: "
    echo " 1. John Hansen's NeXTTool (1.2.1.r5) from BricxCC 3.0"
    echo "    - Required for downloading .rxe binaries to the NXT"
    echo "    - Required for downloading .rfw firmware to the NXT"
    echo " 2. Roman Shaposhnik's LibNXT (0.3) (requires Docker)"
    echo "    - Optional for downloading .rfw firmware to the NXT"
    echo "    - Required for rambooting programs on the NXT"
    echo ""
    echo "The following repository will be downloaded into $repo_dir:" 
    echo "  URL=$url"
    echo "  BRANCH=$branch"
    echo ""
    echo "Then, the following script will be run:"
    echo "  $install_cmd"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Downloading repository: $name"
    cd "$tmp_dir"
    git_latest "$url" "$branch"
    cd "$repo_dir"

    echo "Running command: $install_cmd"
    bash "./$install_cmd"
    cd "$original_dir"

    rm -rf "$repo_dir"
}


# BLUETOOTH
function install_bluetooth() {
    local -a packages=(
        bluetooth bluez
    )
    echo ""
    echo "Bluetooth support allows remote control of the NXT"
    echo "and remote program download."
    echo ""
    echo "The following APT packages will be installed:" 
    echo "  ${packages[@]}"
    echo ""
    if ! confirmation_prompt; then return; fi;
    echo ""

    echo "Installing Bluetooth support..."
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends ${packages[@]}
}

