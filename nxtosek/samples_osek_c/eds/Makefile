# Target specific macros
TARGET = EDS
TARGET_SOURCES := \
	eds.c
TOPPERS_OSEK_OIL_SOURCE := ./eds.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
