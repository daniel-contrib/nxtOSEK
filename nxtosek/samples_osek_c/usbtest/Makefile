# Target specific macros
TARGET = usbtest
TARGET_SOURCES := \
	usbtest.c
TOPPERS_OSEK_OIL_SOURCE := ./usbtest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
