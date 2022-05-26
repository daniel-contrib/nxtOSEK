# Target specific macros
TARGET = i2cwritetest
TARGET_SOURCES := \
	i2cwritetest.c
TOPPERS_OSEK_OIL_SOURCE := ./i2cwritetest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
