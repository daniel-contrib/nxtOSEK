#### Name of resulting executable
TARGET = OSEK_C_Project


#### List of all .c files. Each file on its own line, separate lines by \ character.
TARGET_SOURCES = \
	./src/main.c


#### OSEK .oil files, which configure the RTOS environment and tasks
TOPPERS_OSEK_OIL_SOURCE = \
	./template.oil


#### External source code to include. Each path on its own line, separate lines by \ character.
# USER_INC_PATH = \
#     /usr/lib/libfixmatrix-master				\
# 	  /usr/lib/libfixmath-master/libfixmath
# VPATH = $(USER_INC_PATH)


#### External libraries to statically-link. Use the name of the archive file (maybe?) without the .a extension.
#### Should work if the .a file is somewhere in the USER_INC_PATH
# USER_LIB = \
#     libfixmath


#### User-defined compile macros
# USER_DEF = MY_MACRO


#### Defining NO_RUN_ENTER_STOP_EXIT disables initial display and RUN/STOP/ENTER/STOP buttons.
# USER_DEF += NO_RUN_ENTER_STOP_EXIT


#### Additional compiler flags; See ecrobot/tool_gcc.mak for more info
# USER_C_OPT = 


#### Bitmap image files to include into the executable
# BMP_SOURCES = \
#  	 ./image.bmp


#### WAV sound files to include into the executable
# WAV_SOURCES = \
#  	 ./soundeffect.wav


#### Specify which executables to build
#### Choose only 1 option or leave commented-out to build all three
# BUILD_MODE = ROM_ONLY
# BUILD_MODE = RAM_ONLY
# BUILD_MODE = RXE_ONLY



#### DO NOT MODIFY
O_PATH ?= build
include $(NXTOSEK)/ecrobot/ecrobot.mak
