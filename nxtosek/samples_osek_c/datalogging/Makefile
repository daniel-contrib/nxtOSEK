# Target specific macros
TARGET = datalogging
TARGET_SOURCES := \
	datalogging.c
TOPPERS_OSEK_OIL_SOURCE := ./datalogging.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
