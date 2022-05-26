# Target specific macros
TARGET = soundtest
TARGET_SOURCES := \
	soundtest.c
TOPPERS_OSEK_OIL_SOURCE := ./soundtest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
