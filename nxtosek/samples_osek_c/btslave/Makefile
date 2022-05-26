# Target specific macros
TARGET = btslave
TARGET_SOURCES := \
	btslave.c
TOPPERS_OSEK_OIL_SOURCE := ./btslave.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
