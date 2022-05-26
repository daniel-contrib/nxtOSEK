# Target specific macros
TARGET = nxtmmx
TARGET_SOURCES := \
	nxtmmx.c
TOPPERS_OSEK_OIL_SOURCE := ./nxtmmx.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
