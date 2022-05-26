# Target specific macros
TARGET = PETest
TARGET_SOURCES := \
	template.c
TOPPERS_OSEK_OIL_SOURCE := ./PETest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
