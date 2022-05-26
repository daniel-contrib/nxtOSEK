FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=nxtuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG NXT_TOOLS_DIR=/usr/local/bin
ENV NXTOSEK=/usr/local/src/nxtosek
ENV DISPLAY=:0
ENV WINEARCH=win32
ENV WINEDLLOVERRIDES="mscoree,mshtml="

# Add new nxtosek user with sudo privileges and no password
RUN groupadd -f --gid $USER_GID $USERNAME \
 && useradd --create-home --uid $USER_UID --gid $USER_GID -m $USERNAME  \
 && apt-get update \
 && apt-get install -y --no-install-recommends sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
# Add user permissions for most USB devices \
 && usermod -aG plugdev ${USERNAME} \
 && usermod -aG dialout ${USERNAME} \
 && usermod -aG users ${USERNAME} \
# Packages required to install more packages \
 && apt-get -y install --no-install-recommends \
    make vim wget gnupg software-properties-common \
# Software required for running 3rd party tools \
 && apt-get -y install --no-install-recommends \
    libusb-0.1-4 \
# Add bluetooth support \
 && apt-get install -y --no-install-recommends \
    bluez bluetooth \
# Software required for building 3rd party tools \
#&& apt-get -y install --no-install-recommends \
#   gcc g++ build-essential fpc libusb-dev scons python \
# Build NeXTTool \
#&& cd /src/bricxcc/code \
#&& make -f nexttool.mak \
#&& chmod +x nexttool \
#&& cp nexttool ${NXT_TOOLS_DIR}/nexttool \
# Build LibNXT \
#&& cd /src/libnxt \
#&& scons \
#&& chmod +x ./fwflash \
#&& chmod +x ./fwexec \
#&& cp ./fwflash ${NXT_TOOLS_DIR}/fwflash \
#&& cp ./fwexec ${NXT_TOOLS_DIR}/fwexec \
# Install ARM cross-compiler \
 && apt-get -y install --install-recommends \
    gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
# Install JTAG debugger support \
 && apt-get -y install --no-install-recommends \
    usbutils gdb-multiarch openocd libusb-0.1-4 libusb-dev libftdi1 libftdi-dev \
# Install wine and Xvfb virtual frame buffer (required for wine-headless) \
 && dpkg --add-architecture i386 \
 && wget -nc https://dl.winehq.org/wine-builds/winehq.key \
 && apt-key add winehq.key \
 && rm winehq.key \
 && apt-add-repository https://dl.winehq.org/wine-builds/ubuntu \
 && apt-get update \
 && apt-get -y --no-install-recommends install xvfb winehq-stable \
# Clean up to save space in image \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* \
# Create projects folder \
 && mkdir -p /home/${USERNAME}/projects

# Copy nxtOSEK core files
ADD nxtosek ${NXTOSEK}
COPY VERSION README.md ${NXTOSEK}/

# Copy NXT tools
ADD config/bricxcc /home/${USERNAME}/bricxcc
COPY src/bricxcc/code/nexttool src/libnxt/out/fwexec src/libnxt/out/fwflash ${NXT_TOOLS_DIR}/
# Make sure NXT tools always run as root
RUN chown root:root ${NXT_TOOLS_DIR}/nexttool \
 && chown root:root ${NXT_TOOLS_DIR}/fwexec \
 && chown root:root ${NXT_TOOLS_DIR}/fwflash \
 && chmod a+s ${NXT_TOOLS_DIR}/nexttool \
 && chmod a+s ${NXT_TOOLS_DIR}/fwexec \
 && chmod a+s ${NXT_TOOLS_DIR}/fwflash

# Copy scripts
COPY scripts/wine-headless.sh ${NXT_TOOLS_DIR}/wine-headless

# Switch to NXTOSEK user
WORKDIR /home/${USERNAME}/projects
USER ${USERNAME}

# Initialize a 32-bit Wine install \
RUN wine-headless wineboot

