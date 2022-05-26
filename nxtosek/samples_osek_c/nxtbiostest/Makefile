# Target specific macros
TARGET = execNXTBIOS
TARGET_SOURCES = \
	sample.c map.c
TOPPERS_OSEK_OIL_SOURCE = ./sample.oil

# Compile switches
# Defining NO_RUN_ENTER_STOP_EXIT macro allows to disable initial display and RUN/STOP/ENTER/STOP buttons.
USER_DEF = NO_RUN_ENTER_STOP_EXIT

BUILD_MODE = ROM_ONLY

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
