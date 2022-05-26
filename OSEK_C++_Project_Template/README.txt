*****************************************
***  Creating a New NXT OSEK Project  ***
*****************************************

 1. Copy this folder to wherever you want to store your new project.
	Feel free to rename it as desired.

 2. Open the project in Visual Studio Code.
   
    *For Windows 11/WSL2 ONLY*:
		Press F1 to open the command menu and find:
		`Remote-WSL: New WSL Window Using Distro...` .
		Select the same WSL distro under which you ran install.sh.
		Once WSL is running and connected, open the template.code-workspace file as normal.

    *If developing within Docker image*:
		Press F1 to open the command menu and find:
		`Remote-Containers: Open Workspace In Container` .
		Select the template.code-workspace file located in the project folder.

    *If developing using a local nxtOSEK install (no Docker image)*:
	Press F1 to open the command menu and find: `File: Open Workspace from File` .
	Select the template.code-workspace file located in the project folder.

 3. Write code in ./src, define tasks in template.oil, and edit the build options in Makefile.

    *If developing using a local nxtOSEK install (no Docker image)*:
		You can delete `.devcontainer/` and `run-in-container.sh`.

 4. In a VS Code terminal, run "make all" to compile the project into an NXT executable.
	If you have the "Tasks" extension installed, you can simply click the "make all" button
	in the bottom ribbon.

 5. Connect an NXT to your computer via the USB cable.
	Both `lsusb` and `nexttool -listbricks` should confirm the NXT connection was successful.

    *For Windows 11/WSL2 ONLY*: 
		The USB device should be automatically passed through to WSL within 10 seconds.

 6. If you haven't yet installed the Enhanced Firmware on the NXT, do so by running
 	  "./flash-rxe-firmware.sh".
	The NXT will enter SAM-BA (reset) mode and begin clicking with a blank screen.
	Re-run the script if the firmware download fails.
	Once the firmware download is complete the screen will return to the normal menu.

 7. In a VS Code terminal, run "./flash-rxe-app.sh" to download the .rxe binary to the NXT.

There are many options for configuring your project. Please see the documentation directory and/or the original website (http://lejos-osek.sourceforge.net/) for more information.