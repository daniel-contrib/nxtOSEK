# Target specific macros
TARGET = RMS
TARGET_SOURCES := \
	rms.c
TOPPERS_OSEK_OIL_SOURCE := ./rms.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
