# Target specific macros
TARGET = EventTest
TARGET_SOURCES := \
	template.c
TOPPERS_OSEK_OIL_SOURCE := ./EventTest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
