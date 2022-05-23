# **nxtOSEK Installation**

The nxtOSEK install script expects Ubuntu 20.04 or similar, running natively or in a fully virtualized environment with USB-passthrough support (WSL2, Virtualbox, VMWare, etc.)

This process has been tested on Ubuntu 20.04 running in VMWare and on Ubuntu 20.04 WSL2 on Windows 11. However, other Debian-based distros with Docker support and USB passthrough will likely work as well.

---

## Installation under Ubuntu Desktop 20.04 (Non-WSL)

### Prerequisites:

- [Visual Studio Code](https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-20-04/) for Ubuntu Desktop and the [Remote-Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

- If running in a Virtual Machine (VMWare, Virtualbox, etc) you should set a USB device filter to autoconnect NXTs to your VM. Look up instructions for your particular software.
You need to autoattach both NXT and SAM-BA devices (for downloading firmware); the relevant Vendor:Product IDs are 0694:0002 and 03eb:6124, respectively.

### Installation:

1. Clone this repository:
   
    ```
    git clone https://github.com/danielk-98/nxtOSEK
    ```

2. Run install script:
    ```
    cd ./nxtOSEK
    ./install.sh
    ```
    This will download and install Docker using the official Docker install script.
    You will also be prompted to download the latest release of the nxtOSEK Docker image (this may take awhile). If you opt out, you can download it later using ./scripts/download_release.sh or download it manually from this repo's Releases page.

3. See the section "Starting A New nxtOSEK Project" for how to get started!

---

## Installation under Windows 11 (WSL2-Ubuntu)

### Prerequisites:

- Windows 11 (Likely not working in Windows 10 due to Win11-exclusive features)
- [WSL2](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support) with Ubuntu 20.04 LTS.
- [Visual Studio Code](https://code.visualstudio.com/download) for Windows, the [Remote-Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension, and the [Remote-WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) extension.
- [USB-IP](https://github.com/dorssel/usbipd-win/releases/) server  for Windows

### Installation:

1. Open VS Code. In File->Preferences->Settings, search for `remote.containers.executeInWSL` . Check the box to enable the option.
   If you have multiple WSL instances, you can also change the `remote.containers.executeInWSLDistro` option and select which distro will contain Docker.

In a new WSL terminal:

2. Clone this repository:
   
    ```
    git clone https://github.com/danielk-98/nxtOSEK
    ```

3. Run install script:
    ```
    cd ./nxtOSEK
    ./install.sh
    ```
    This will download and install Docker using the official Docker install script.
    You will also be prompted to download the latest release of the nxtOSEK Docker image (this may take awhile). If you opt out, you can download it later using ./scripts/download_release.sh or download it manually from this repo's Releases page.

4. See the section "Starting A New nxtOSEK Project" for how to get started!

--- 

## Starting A New nxtOSEK Project

    Note: nxtOSEK **can** be used independently of VS-Code. From an Ubuntu or WSL2 terminal, launch `./scripts/bash_release.sh` to spin up a temporary nxtOSEK container and connect to a Bash terminal.

There are currently project templates available for C and C++ development using the OSEK kernel.

1. Choose OSEK_C_Project_Template or OSEK_C++_Project_Template, then copy the folder to wherever you want to store your new project. Feel free to rename it as desired.

Then open the project in an nxtOSEK development container:

2. Open Visual Studio Code.
   
    2a.	*For Windows 11/WSL2 ONLY*: press F1 to open the command menu and find: `Remote-WSL: New WSL Window Using Distro...` . Select the same WSL distro under which you ran install.sh.

    - The Project workspace will only open if VS Code is already connected to a running WSL2 instance.

3. Press F1 to open the command menu and find: `Remote-Containers: Open Workspace In Container` .	Select the template.code-workspace file located in this folder.
	Ignore the warning message regarding relative paths.

Edit the project, or leave as-is (helloworld code is already included).

4. Write code in ./src, define tasks in template.oil, and edit the build options in Makefile.

5. In a VS Code terminal, run "make all" to compile the project into an NXT executable. If you have the [Tasks extension](https://marketplace.visualstudio.com/items?itemName=actboy168.tasks)  installed, you can simply click the "make all" button in the bottom ribbon.

Finally, download the program to the NXT.

6. Connect an NXT to your computer via the USB cable.
	The device should be automatically passed through to the running Docker container. Both `lsusb` and `nexttool -listbricks` should confirm the NXT connection was successful.

7. If you haven't yet installed the Enhanced Firmware on the NXT, do so by running "./flash-rxe-firmware.sh"

	The NXT will enter SAM-BA (reset) mode and begin clicking with a blank screen.
	Re-run the script if the firmware download fails.
	Once the firmware download is complete the screen will return to the normal menu.

8. In a VS Code terminal, run "./flash-rxe-app.sh" to download the .rxe binary to the NXT.


There are many options for configuring your project. Please see the documentation directory and/or the original website (http://lejos-osek.sourceforge.net/) for more information.

