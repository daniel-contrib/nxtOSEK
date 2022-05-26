# Target specific macros
TARGET = btmaster
TARGET_SOURCES := \
	btmaster.c
TOPPERS_OSEK_OIL_SOURCE := ./btmaster.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
