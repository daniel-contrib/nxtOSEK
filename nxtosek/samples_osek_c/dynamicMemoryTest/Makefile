# Target specific macros
TARGET = dmt
TARGET_SOURCES := \
	dynamicMemoryTest.c
TOPPERS_OSEK_OIL_SOURCE := ./dynamicMemoryTest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
