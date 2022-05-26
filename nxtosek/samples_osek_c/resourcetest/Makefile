# Target specific macros
TARGET = ResourceTest
TARGET_SOURCES := \
	resourcetest.c
TOPPERS_OSEK_OIL_SOURCE := ./ResourceTest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
