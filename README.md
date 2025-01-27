# **nxtOSEK**
## A C/C++ compiler and realtime kernel for the LEGO Mindstorms NXT microcontroller
### Original author: Takashi Chikamasa (takashic@users.sourceforge.net) 
### Official site (outdated): http://lejos-osek.sourceforge.net/


## **Motivation:**
The Lego Mindstorms NXT is a versatile and powerful platform for robotics experimentation.
NXT-OSEK provides realtime kernels based on
[TOPPERS/OSEK](https://www.toppers.jp/en/index.html) and
[TOPPERS/JSP](https://www.toppers.jp/en/jsp-kernel-e.html),
an NXT-compatible C/C++ compiler,
and device driver APIs for easy access to LEGO hardware.

The original nxtOSEK project is no longer being maintained by its original authors.
Versions 3.01+ are unofficial releases intended to modernize the NXT-OSEK toolchain with the following goals:
 - Fix long-standing bugs
 - Improve support on both Linux and Windows
 - Provide general usability improvements
 - Future-proof the setup as much as possible to maintain compatibility for years to come.

## **Installation and Usage:**
Please see `INSTALL.md` for setup and usage instructions.

## **New Features:**
- Working install script

    install.sh handles the required system configuration for both local (no-Docker) and Docker installs of the nxtOSEK development environment.

- Fully encapsulated nxtOSEK development environment using Docker
  
    An optional Docker image (see Releases page) contains all necessary compilers, scripts, tools, pre-installed and working.

- Support for Debian-based Linux distros, including WSL2 on Windows 11

    USB passthrough is automatically configured on WSL2.
  
- Visual Studio Code (VSCode) integration

    C/C++ linting and Intellisense are now working. Preconfigured tasks let you compile and download your program to the NXT with the click of a button!
  
- Build scripts updated for ARM-NONE-EABI cross-compiler

    No longer requires custom compilers or outdated dependencies.

- Includes all required tools for interfacing with the NXT

    Latest versions of John Hansen's NeXTTool and Roman Shaposhnik's LibNXT (fwexec and fwflash) are available through the install script, and are included by default in the Docker image.

- Quick-start Templates for OSEK C and OSEK C++ VSCode projects 

    Create a new program, compile it, and download it to the NXT in minutes!



## **Planned Features:**
- Fix broken compile process for nxtOSEK's appflash utility (what deps do we need to have for this?)
- VSCode integration with OpenOCD/GDB for real-time NXT debugging (requires an NXT hardware mod!)
- Project templates for JSP kernel (OSEK has a few kernel bugs; JSP may work better?)


## **Change Log:**
### What's new in 3.02 (May 2022 - Daniel Kennedy)
- Added option for local nxtOSEK installation (no Docker required!)

    This is currently the recommended way to use nxtOSEK (see `INSTALL.md` for details).
    The Docker image release is still available and working, and will likely remain working long after the local install option is broken.


### What's new in 3.01 (April 2022 - Daniel Kennedy)
- Added Docker image.
 
    The provided Docker image contains all necessary compilers, scripts, tools, pre-installed and working.
    This eliminates most external dependencies and simplifies the deployment process.

- Added Linux (Ubuntu) support.

    Official installation instructions for Linux no longer work. Docker fixes this.
    Any recent Linux system capable of running Docker should work. 

- Added Windows support through WSL2.

    WSL1 is not supported. WSL2 requires Windows 11 or Windows 10, Version 1903, Build 18362 or later.

- Added Visual Studio Code (VSCode) integration.
- Removed CYGWIN support (WSL2 replaces this)

    Official installation instructions for CYGWIN no longer work, and WSL2 is functionally superior anyway.

- Removed Eclipse support (VSCode replaces this)

    Official installation instructions for Eclipse no longer work and integration between Eclipse and Docker is difficult.

- Changed toolchain to support ARM-NONE-EABI cross-compiler.

    This is automatically installed within the Docker image. Fixes a lot of dependency problems and the modern compiler comes with a few optimizations as well.

- Removed relative paths in the project makefiles.

    Now an NXTOSEK project folder can be located anywhere on the system. Requires an environment variable NXTOSEK to point to the root path of nxtOSEK (this is set automatically within the Docker image)

- Added required NXT tools to NXT-OSEK build process (libNXT and nexttool)

- Added templates for OSEK C and OSEK C++ VSCode projects

    Simplifies creation of new nxtOSEK programs. See README.txt inside the project template folder.

- Added documentation folder with some useful resources for OSEK development

- Updated all sample projects to use new makefile structure

    "make all" can be called from anywhere as long as the NXTOSEK environment variable is set.


### What's new in 3.00 (January 2014)
- Switched version of GNU Tools for ARM Embedded to 4.8-2013-q4-major to be able to use nxtOSEK in MacOS
- Updated cpu_support.S, debug.S, ecrobot_init.S, init.S and interrupt.s according to 
Thumb->ARM call and thumb-interwork problem on 4.7 (Applies to 4.8 also)
https://answers.launchpad.net/gcc-arm-embedded/+question/231518


### What's new in 3.00b0 (October 2013)
- Switched GCC toolchain from GNU ARM to GNU Tools for ARM Embedded (https://launchpad.net/gcc-arm-embedded)
- Generate linker scripts statically (SED is not needed anymore)
Note that the new toolchain seems to work well with only C, but some C++ code does not work as expected.

### What's new in 2.18 (January 2013)
- Fixed bugs in PCM sound stream C API and added new functions for PCM sound playback
- Added wavelooptest C sample (see samples_c\wavelooptest)
Special thanks to Eiji Sato who developed the API and the sample originally for ET ROBOCON 2012(http://www.etrobo.jp/2012/)
- Improved stability of NXT BIOS
Special thanks to Koji Shimizu
- Support OSEK COM (see samples_c\comtest or samples_c++\OsekCom)
Note that OSEK COM requires sg2.10.exe in TOPPERS ATK1 (http://www.toppers.jp/atk1-download.html)
Special thanks to Professor Naohiko Shimizu (http://www.ip-arch.jp/)
- Fixed a bug in ecrobot.mak and ecrobot++.mak
Special thanks to Dariusz Antoniuk

### What's new in 2.17 (February 2012)
- Added ecrobot_exec_NXT_BIOS C/C++ API to be able to execute NXT BIOS from application automatically
(See samples_c\executeNXTBIOS, samples_c++\cpp\ExecNXTBIOS samples)
Note that the new C/C++ API works only when NXT BIOS is used. Otherwise it does nothing
Note that the new C/C++ API requires NXT BIOS 1.04 or later
- Updated NXT BIOS to 1.04
  - Uploaded application is executed after program upload without turn off/on the NXT
  - Improved robustness of program upload (I hope)
  - Program upload progress bar is replaced with simple "Uploading..." message to reduce IRQ load for LCD updates
Note that the new C/C++ API and the update of NXT BIOS improve usability of NXT BIOS and user can design prefered application upload sequence

### What's new in 2.161 (December 2011)
- Updated ecrobot C++ API reference generated by doxygen
- Updated ecrobot_base.c to support ARM EABI
Special thanks to Dmitry Prokhorov

### What's new in 2.16 (December 2011)
- Support HiTechnic DC Motor Controller for TETRIX in C API (See samples_c\tetrix)
Special thanks to Loic Cuvillon to develop the C API and the C sample
- Added installation instructions for Mac OS X (Lion)
Special thanks to Dmitry Prokhorov
- Updated installation instructions for Linux (Ubuntu 11.10)
Special thanks to Lauro Ojeda
- Added samples_c\mathtest sample
- Modified LFLAG in tool_gcc.mak to link ANSI-C math library properly
Special thanks to Paul Besson to report the bug

- Added NO_RUN_ENTER_STOP_EXIT compile switch macro to enable to suppress initial splash screen and disable RUN/ENTER/STOP/EXIT operations assignment to the NXT buttons
(See samples_c\noRunEnterStopExit, samples_c\noRunEnterStopExitAndBluetooth and samples_c++\cpp\Nxt2 samples)
- Added ecrobot_restart_NXT and ecrobot_shutdown_NXT C API to be able to re-start/shutdown NXT
- Added ecrobot_get_button_state C API and BTN_ORANGE_RECT/BTN_LEFT/BTN_RIGHT/BTN_GRAY_RECT macros to be able to retrieve status of the buttons on the NXT
- Added the above new C API equivalent properties to ecrobot::Nxt C++ class
Note that the above new features allows users to design user orignal interface with the NXT LCD and buttons instead of nxtOSEK default
initial display and RUN/ENTER/STOP/EXIT buttons assignment. It also reduces ROM size about 2 Kbytes.

### What's new in 2.15 (March 2011)
- Improved and fixed bugs in Bluetooth C/C++ API
1. Removed BT_BUF_SIZE macro in C API and MAX_BT_DATA_LENGTH in C++ API
2. Corrected maximum size of Rx data packet buffer to be 126 (formerely, 254 bytes) for ecrobot_read_bt_packet and related C++ API 
3. Fixed bugs in ecrobot_get_device_address, ecrobot_get_device_name and related C++ API
4. [RECOMMENDED TO USE] Added C/C++ API to send/read data without data frame restrictions
Note thath the new C/C++ send/read API are faster and it allows user to fully design data frame structure (extra 2 bytes can be used in 
user application)
5. Added C/C++ API to get signal strength (RSSI)
6. Added Bluetooth C/C++ samples 
 (samples_c\btinfo, samples_c\btecho, samples_c++\cpp\BluetoothInformation, samples_c++\cpp\BluetoothEcho)
Special thanks to Yamaguchi-san

- Changed the scope range of ecrobot\c\colorsensor.h from global to internal use only
Special thanks to Yamaguchi-san
-  Fixed a bug in ecrobot_sound_wav C API and Speaker C++ API
(enable to play WAV files that don't contain 2 byte dummy zeros in the fmt block)
Special thanks to Eric Matsui-san

### What's new in 2.14 (November 2010)
- Added NXT2.0 Color Sensor C/C++ API (See nxtOSEK\samples_c\nxtcolorsensortest and \nxtOSEK\samples_c++\cpp\NxtColorSensor)
Special thanks to Marcel Hein and Benjamin Bode who developed the APIs
- Added HiTechnic Prototype Sensor C API (See nxtOSEK\samples_c\hitechtest3)
- Improved robustness of NXT BIOS and appflash.exe (upload sequence, check sum and error routines)
Note: If program uproad process was stopped due to some reason (e.g. USB disconnection, data corruption)
      Keep pushing EXIT button on the NXT longer than one second to shut down the NXT.
- Fixed a bug in ECRobot C++ API(GyroSensor.setOffset)
- Fixed a bug for ecrobot_device_initialize when application program is re-started

### What's new in 2.13 (May 2010)
- Added ECRobot RS485 C/C++ API (See samples_c\rs485test and samples_c++\cpp\RS485)
Special thanks to Simone Casale Brunet to develop RS485 API.
- Added ECRobot mindsensors Multiplexer for NXT Motors (See samples_c\nxtmmxtest)
Special thanks to Thanh Pham who develop the API

### What's new in 2.12 (March 2010)
- sg.exe is removed from nxtOSEK (March 01, 2010)
To keep the terms of Sourceforge.net, I have decided to remove sg.exe (an OSEK OIL parser and code generator) from 
nxtOSEK. sg.exe which was included in nxtOSEK is same as sg.exe in TOPPERS/OSEK 1.1 at TOPPERS project where outside of Sourceforge.net. TOPPERS/OSEK 1.1 is available here: http://www.toppers.jp/download.cgi/osek_os-1.1.lzh
osek_os-1.1.lzh is compressed as LZH format and it needs to use a lzh supported file extractor, for example, 7-zip
(http://www.7-zip.org/) which would work in Windows XP/Vista and Linux.
To use sg.exe in osek_os-1.1.lzh for nxtOSEK:
 - Extract osek-os-1.1.lzh
 - Copy extracted /toppers_osek/sg/sg.exe to nxtOSEK/toppers_osek/sg directory 

- Corrected inconsistent linefeeds (Unix + DOS) in the source files
  + Special thanks to Bernhard Merkle

### What's new in 2.11 (January 2010)
- ECRobot C++ API(I2C devices and Clock) are supported by TOPPERS/JSP(ITRON)
  + Special thanks to mai-mai san (http://www.chihayafuru.jp/)
- Corrected PSP-Nx class of ECRobot C++ API to work properly
  + Special thanks to Rade to test it patiently
- Added mindsensor NxtCam C API developed by Loic Royer
  + Check his cool nxtjohnny5 project: http://code.google.com/p/nxtjohnny5/
- Added mindsensor NxtCam C++ API (see samples_c++\cpp\Camera)
  + Based on Loic's C API (but, never tested because I don't have a NXTCam)
- Added BTConnection C++ API. This is a helper class for Bluetooth connection.
  (see samples_c++\cpp\BTConnection)
- Added clearRow member function to Lcd C++ API.
- Refactored and added dynamic gyro sensor offset calibration feature to nxtway_gs++ sample
  (see samples_c++\cpp\NXTway_GS++)
- Added NXTway-GS++ based Line Tracing robot (see samples_c++\cpp\NXTway_LT)
- Added Tribot R/C sample (see samples_c++\cpp\TribotRC\)

### What's new in 2.10 (May 2009)
- Improve ARM7-AVR communication to be more robust (especially effective for TOPPERS/JSP)
  + Updated lejos device drivers (the low level stuff has become most stable ever!)
  + Note that this change also makes NXT BIOS update to v1.02
- Refactored ECRobot C++ API
  + Added global C++ new/delete overload to reduce memory consumption (ecrobot\c++\util\New.cpp)
    * Overloaded new/delete does not have exception handlings and is not thread safe
    * Improved linker script for heap memory (ecrobot\c\sam7_ecrobot.lds)
  + Changed behavior of Motor.reset() C++ API
    * Stop the motor immediately (with brake) even if Motor.setBrake(false) was set
  + Unified data type of string parameters to (const) CHAR* in Bluetooth C/C++ API
  + Removed unneccessary explicit destructors to reduce memory consumption
  + Added explicit keyword to converting constructors to prevent implicitly converted
  + Inlined simple forwarded member functions
  + Re-ordered class member to public->protected->private
- Fixed a bug in ecrobot_get_sonar C API for supporting multiple sonars
  + Special thanks to Iheanyi Umez-Eronini to report and fix the bug
- Fixed a bug in ecrobot_read_bt_packet C API and ECRobot Blutooth C++ API
  + Special thanks to EunJin Jeong to report and fix the bug
- Fixed a bug in ecrobot_sound_wav C API and ECRobot Speaker.playWav C++ API
  + Special thanks to epokh to report the bug

### What's new in 2.09 (April 2009)
- Added no C++ RTTI option (fno-rtti) for .cc and .cpp source files
Note that it saved several Kbytes of memory!!
- Added LegoLight class in ECRobot C++ API
- Refactored ECRobot C++ API according to GCC warning options and design patterns
- Fixed bugs in tool_gcc.mak and ecrobot++.mak

### What's new in 2.08 (March 2009)
- Added ECRobot C++(.cpp) API (./ecrobot\c++) and samples (samples_c++\cpp)
doxygen generated C++ API reference is here: ./ecrobot/c++/html/index.html

- Added HiTechnic IR Seeker, Color Sensor and Compass Sensor C API
- Added ecrobot_wait_I2C_ready API and fixed bugs in I2C send/receive API
- Added SetRelAlarm API sample (samples\alarmManualTest)

### What's new in 2.07 (February 2009)
- Added C++ sprite animation API and samples (samples\c++\sprite_*)
Note that C++ sprite animation API and samples are developed by Jon C. Martin
- Added NXT sleep feature. 
If there was no operation within 10minutes after starting the system (not application), 
NXT is automatically turned off to avoid battery discharge. 
- Fixed a bug in ECRobot USB API (ecrobot\nxtusb.c)
- Fixed a bug in Makefile for C++ library (c++\src\Makefile)

### What's new in 2.06 (January 2009)
- Fixed bugs in nxtcommfantom API (ecrobot\nxtcommfantom)
Note that multiple NXTs connection seem to not work, so the API is restricted for only a NXT. 

### What's new in 2.05 (January 2009)
- Officially supported for Windows Vista (Enhanced NXT firmware and NXT BIOS) 
- Updated ECRobot USB C API to be able to communicate with LEGO MINDSTORMS NXT Driver (samples\usbtest, usbhost)
- Updated appflash.exe and NXT BIOS to be able to communicate with LEGO MINDSTORMS NXT Driver
Note that NXT BIOS is updated to v1.01
- Obsoleted biosflash.exe and replaced with NeXTTool to upload NXT BIOS 
- Support for TOPPERS/JSP as an RTOS kernel in addtion to TOPPERS/ATK(OSEK)
Note that TOPPERS/JSP is complied with Japan original open RTOS specification ��ITRON 4.0
Note that nxtOSEK C++ API uses some OSEK APIs, so it can't be used with JSP
Note that porting TOPPERS/JSP to the NXT is done by Monami Software Limited Partnership, JAPAN.
- Refactored makefiles and replaced lejos_osek.tmf with ecrobot.mak
(lejos_osek.tmf is still supported for backward compatibility)
- Refactored NXT button status check routines

### What's new in 2.04 (November 2008)
- Support for C malloc/free (but not thread safe)
- Support for C++ new/delete, Boost smart pointer (but not thread safe)
Special thanks to Jon C. Martin

### What's new in 2.03 (October 2008)
- Added NXTway-GS C API(see new NXTway-GS sample)
- Added mindsensors PSPNx C++ API
Special thanks to Jon C. Martin
- Support for multiple HiTechnic Acceleration Sensors on a NXT
- Fixed a bug in ecrobot_RUN_button_pressed/ecrobot_ENTER_button_pressed API
- Added biped robot sample using LATTEBOX NXTe/LSC (via I2C interface API)
- Added LATTEBOX LSC-22 sample
- Removed NXTway-DS sample

### What's new in 2.02 (June 2008)
- Support for enhanced LEGO standard firmware (see #168 for more detailed information)
Special thanks to Sivan Toredo and John Hansen. <http://www.tau.ac.il/~stoledo/lego/nxt-native/>
- Added LATTEBOX NXTe RC servo controller sample (see samples/nxte)
Special thanks to Yu Yang san.

### What's new in 2.01 (May 2008)
- Changed the project name from LEJOS OSEK to nxtOSEK. 
This change is not due to legal issue. However, LEJOS(leJOS) sometimes seems to make
people misunderstand LEJOS OSEK as "an alternative Java VM" or "an add-on of leJOS NXJ".
Therefore, we have changed the name, but, it would not affect the backward compatibility
of APIs and existing users applications.
- Support for BMP file format for LCD graphics (see samples/bmptest, anime)
- Support for WAV file format for sound generation. (see samples/wavtest)
- Added USB API (see samples/usbtest)
- Added I2C API
- Support Bluetooth run-time connection (see samples/btmaster, btslave)
- User customizable BMP file based splash screen
- No functionality changes in NXT BIOS (you don't need to update NXT BIOS)

### What's new in 2.00 (April 2008)
Until LEJOS OSEK 1.10, LEJOS OSEK program had to be uploaded into SRAM of AT91SAM7S256 
in the NXT due to Flash endurance. This used to be a big restriction of LEJOS OSEK 
compared to other NXT firmwares and programming environments. But now...
The new LEJOS OSEK provides: 
 - Execution of LEJOS OSEK application in Flash/SRAM.
 - NXT BIOS supports LEJOS OSEK application flash WITHOUT touching the lock bits of AT91SAM7S.
 - 224Kbytes Flash and appx. 50Kbytes SRAM for user application and LEJOS OSEK in Flash.
 - New splash screen and main screen with status bar.
 - Speed up compilation time by archiving LEJOS OSEK application independent part.
