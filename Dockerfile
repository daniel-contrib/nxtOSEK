############################################################################################
# STAGE 1: Compile NXT utilities (and dependencies) for this platform
############################################################################################
#FROM ubuntu:14.04 AS stage1
#ARG DEBIAN_FRONTEND=noninteractive

# Install host compiler and prereqs
#RUN apt-get update \
# && apt-get -y --no-install-recommends install \
#        apt-transport-https build-essential texinfo unzip \
#        libgmp-dev libmpfr-dev libppl-dev libcloog-ppl-dev \ 
#       tk-dev ncurses-dev wget gzip tar software-properties-common \ 
#        xvfb gcc-4.8 gdb gdb-multiarch vim scons python3 \
#        libc-dev make autoconf libtool libusb-dev

# Copy source code for NXT tools
#ADD src /src
#WORKDIR /src

# Build LibUSB
#RUN tar xf /src/libusb-0.1.12.tar \
# && mkdir -p /build/libusb \
# && cd /build/libusb \
# && ls /src \
# && /src/libusb-0.1.12/configure \
# && make CFLAGS="-Wno-error" CXXFLAGS="-Wno-error" install
# make install

# Build LibNXT
#RUN tar xf /src/libnxt-0.3.tar \
# && cd /src/libnxt-0.3 \
# && scons \
# && chmod +x ./fwflash \
# && chmod +x ./fwexec
## cp ./fwflash $TOOLDIR/fwflash
## cp ./fwexec $TOOLDIR/fwexec

# Build NeXTTOOl
#RUN unzip /src/bricxcc-3.3.8.10.zip \
# && cd /src/bricxcc-3.3.8.10 \
# && make -f nexttool.mak \
# && chmod +x ./nexttool
## cp ./nexttool $TOOLDIR/nexttool

# Build modified LibNXT from the LeJOS-OSEK source code
#ADD nxtosek /nxtosek
#RUN cd /nxtosek/lejos_nxj/src/libnxt \
## && scons

############################################################################################
# STAGE 2: Install NXTOSEK and dependencies 
############################################################################################
FROM ubuntu:20.04 AS stage2
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=nxtosek
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV NXTOSEK=/home/$USERNAME
ENV NXT_TOOLS_DIR=/usr/local/bin
ENV DISPLAY=:0
ENV WINEARCH=win32
ENV WINEDLLOVERRIDES="mscoree,mshtml="

# Load 3rd-party source code into image
ADD src /src

# Add new nxtosek user with sudo privileges and no password
RUN groupadd -f --gid $USER_GID $USERNAME \
 && useradd --create-home --uid $USER_UID --gid $USER_GID -m $USERNAME  \
 && apt-get update \
 && apt-get install -y --no-install-recommends sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
# Add user permissions for most USB devices \
 && usermod -aG plugdev nxtosek \
 && usermod -aG dialout nxtosek \
 && usermod -aG users nxtosek \
# Packages required to install more packages \
 && apt-get -y install --no-install-recommends \
    make vim wget gnupg software-properties-common \
# Software required for building 3rd party tools \
 && apt-get -y install --no-install-recommends \
    gcc g++ build-essential fpc libusb-0.1-4 libusb-dev scons python \
# Build NeXTTool \
 && cd /src/bricxcc/code \
 && make -f nexttool.mak \
 && chmod +x nexttool \
 && cp nexttool ${NXT_TOOLS_DIR}/nexttool \
# Build LibNXT \
 && cd /src/libnxt \
 && scons \
 && chmod +x ./fwflash \
 && chmod +x ./fwexec \
 && cp ./fwflash ${NXT_TOOLS_DIR}/fwflash \
 && cp ./fwexec ${NXT_TOOLS_DIR}/fwexec \
# Install ARM cross-compiler and debuggers \
 && apt-get -y install --install-recommends \
    usbutils gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib gdb-multiarch openocd \
# Add bluetooth support \
 && apt-get install -y --no-install-recommends \
    bluez bluetooth \
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
 && rm -rf /src

# Install scripts into NXT_TOOLS_DIR
ADD scripts/include ${NXT_TOOLS_DIR}

# Install NXTOSEK
ADD nxtosek ${NXTOSEK}
COPY VERSION README.md ${NXTOSEK}/

# Switch to NXTOSEK user
WORKDIR ${NXTOSEK} 
USER ${USERNAME}

# Initialize a 32-bit Wine install
RUN wine-headless wineboot



