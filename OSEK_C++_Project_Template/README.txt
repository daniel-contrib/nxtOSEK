*****************************************
***  Creating a New NXT OSEK Project  ***
*****************************************

1. Copy this folder to wherever you want to store your new project and rename it as desired.
2. Open Visual Studio Code.
   	2a.	On Windows 11 ONLY, press F1 to open the command menu and select:
	    "Remote-WSL: New WSL Window Using Distro..."
		Select the WSL distro under which you ran install.sh.
3. Press F1 to open the command menu and select: "Remote-Containers: Open Workspace In Container"
	Select the template.code-workspace file located in this folder.
	Ignore the warning message regarding relative paths.
4. Write code in ./src, define tasks in template.oil, and edit the options in Makefile (heavily commented).
5. In a VS Code terminal, run "make all" to compile the project into an NXT executable.
6. Connect an NXT to your computer via the USB cable.
	The device should be automatically passed through to the VS Code docker container.
7. If you haven't yet installed the Enhanced Firmware on the NXT, do so by running "./flash-rxe-firmware.sh"
	The NXT will enter SAM-BA (reset) mode and begin clicking with a blank screen.
	Re-run the script if the firmware download fails.
	Once the firmware download is complete the screen will return to the normal menu.
8. In a VS Code terminal, run "./flash-rxe-app.sh" to download the .rxe binary to the NXT.
