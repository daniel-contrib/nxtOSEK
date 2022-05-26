# Target specific macros
TARGET = SpeedTest
TARGET_SOURCES := \
	speedtest.c
TOPPERS_OSEK_OIL_SOURCE := ./speedtest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
