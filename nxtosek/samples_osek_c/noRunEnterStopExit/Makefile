# Target specific macros
TARGET = user_def_btn
TARGET_SOURCES = \
	sample.c
TOPPERS_OSEK_OIL_SOURCE = ./sample.oil

# Compile switches
# Defining NO_RUN_ENTER_STOP_EXIT macro allows to disable initial display and RUN/STOP/ENTER/STOP buttons.
USER_DEF = NO_RUN_ENTER_STOP_EXIT

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
