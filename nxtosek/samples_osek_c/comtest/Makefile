# Target specific macros
TOPPERS_KERNEL = OSEK_COM
TARGET = COMtest
TARGET_SOURCES = \
	comtest.c
TOPPERS_OSEK_OIL_SOURCE = ./comtest.oil

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
