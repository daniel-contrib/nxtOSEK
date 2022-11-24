# **nxtOSEK Installation**

The nxtOSEK install script expects Ubuntu 20.04 or similar, running natively or in a fully virtualized environment with USB-passthrough support (WSL2, Virtualbox, VMWare, etc.)

This process has been tested on Ubuntu 20.04 running in VMWare and on Ubuntu 20.04 WSL2 on Windows 11. However, other Debian-based distros with Docker support and USB passthrough will likely work as well.

---

### Prerequisites for Ubuntu Desktop 20.04 (Non-WSL):

- [Visual Studio Code](https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-20-04/) for Ubuntu Desktop
- *Optional*: [Remote-Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
- If running in a Virtual Machine (VMWare, Virtualbox, etc) you should set a USB device filter to autoconnect NXTs to your VM. Look up instructions for your particular software.
You need to autoattach both NXT and SAM-BA devices (for downloading firmware); the relevant Vendor:Product IDs are 0694:0002 and 03eb:6124, respectively.

### Prerequisites for Windows 11 (WSL2-Ubuntu):

- Windows 11 (Likely not working in Windows 10 due to Win11-exclusive features)
- [WSL2](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support) with Ubuntu 20.04 LTS.
- [Visual Studio Code](https://code.visualstudio.com/download) for Windows and the [Remote-WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) extension.
- *Optional*: [Remote-Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
- [USB-IP](https://github.com/dorssel/usbipd-win/releases/) server  for Windows

---

## Installation:

1. Install prerequisite software for your system (see above)

2. Open a new terminal. Clone this repository *with submodules*:
   
    ```
    git clone --recursive https://github.com/daniel-contrib/nxtOSEK
    ```

3. Run install script:
    ```
    cd nxtOSEK
    ./install.sh
    ```
    After some preliminary configuration, the script will ask you to download the nxtOSEK Docker image.

    If Docker is not installed or if you opt-out of the Docker image, the nxtOSEK toolchain can be installed locally instead (recommended). However, this requires installing many new packages (Wine, ARM cross-compiler, etc.) on your system.

    The Docker image may take a long time to download but is much less likely to break far in the future due to missing dependencies, since it is already pre-compiled and working.

    **The local installation option is recommended - but if packages are no longer available for your system, download the Docker image instead.**


---

## Starting A New nxtOSEK Project


1. Choose `OSEK_C_Project_Template` or `OSEK_C++_Project_Template`, then copy the folder to wherever you want to store your new project. Feel free to rename it as desired.


2. Open the project in Visual Studio Code.
   
    *For Windows 11/WSL2 ONLY*: Press F1 to open the command menu and find: `Remote-WSL: New WSL Window Using Distro...` . Select the same WSL distro under which you ran install.sh. Once WSL is running and connected, open the template.code-workspace file as normal.

    *If developing within Docker image*: Press F1 to open the command menu and find: `Remote-Containers: Open Workspace In Container` .	Select the template.code-workspace file located in the project folder.

    *If developing using a local nxtOSEK install (no Docker image)*: Press F1 to open the command menu and find: `File: Open Workspace from File` .	Select the template.code-workspace file located in the project folder.


3. Write code in ./src, define tasks in template.oil, and edit the build options in Makefile. Or leave the project as-is; "helloworld" code is already included.

    *If developing using a local nxtOSEK install (no Docker image)*: You can delete `.devcontainer/` and `run-in-container.sh`, as these will not be needed.

4. In a VS Code terminal, run "make all" to compile the project into an NXT executable. If you have the [Tasks extension](https://marketplace.visualstudio.com/items?itemName=actboy168.tasks)  installed, you can simply click the "make all" button in the bottom ribbon.

5. Connect an NXT to your computer via the USB cable.

    *For Windows 11/WSL2 ONLY*: 
	The USB device should be automatically passed through to WSL within 10 seconds. Both `lsusb` and `nexttool -listbricks` should confirm the NXT connection was successful.

6. If you haven't yet installed the Enhanced Firmware on the NXT, do so by running "./flash-rxe-firmware.sh"

	The NXT will enter SAM-BA (reset) mode and begin clicking with a blank screen.
	Re-run the script if the firmware download fails.
	Once the firmware download is complete the screen will return to the normal menu.

7. In a VS Code terminal, run "./flash-rxe-app.sh" to download the .rxe binary to the NXT.


There are many options for configuring your project. Please see the documentation directory and/or the original website (http://lejos-osek.sourceforge.net/) for more information.


---

## Developing in Docker in WSL

It is possible to run VS Code inside a Docker container inside WSL. This is currently the most future-proof way to use nxtOSEK on Windows.

1. Complete the installation as outlined above. While running `install.sh`, choose the options to install Docker and download the nxtOSEK Docker image.

2. Open VS Code on Windows. In File->Preferences->Settings, search for `remote.containers.executeInWSL` . Check the box to enable the option.
   If you have multiple WSL instances, you can also change the `remote.containers.executeInWSLDistro` option and select which distro contains the nxtOSEK Docker image.

3. Proceed with project setup as normal. Make sure VS Code is open and connected to WSL before running `Remote-Containers: Open Workspace In Container`

---

## Tips for developing nxtOSEK using Docker

If the nxtOSEK Docker image has been installed, you can use `my_project/run-in-container.sh` to run commands in a Docker container with your project files. For example (Run from the root of your project folder):

Build your project (Does not need nxtOSEK toolchain installed locally!):

`./run-in-container.sh make all`

Clean your project:

`./run-in-container.sh make clean`

Open an interactive terminal containing your project workspace and an nxtOSEK development environment:

`./run-in-container.sh bash`

Download your program to the NXT over USB (Does not need the NXT tools installed locally!):

`./run-in-container.sh ./flash-rxe-app.sh`

