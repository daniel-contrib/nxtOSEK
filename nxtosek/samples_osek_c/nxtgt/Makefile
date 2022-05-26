# Target specific macros
TARGET = nxtgt
TARGET_SOURCES := \
	nxtgt.c
TOPPERS_OSEK_OIL_SOURCE := ./nxtgt.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
