# Target specific macros
TARGET = nxte22_test
TARGET_SOURCES := \
	nxte22_test.c \
	nxte22.c
TOPPERS_OSEK_OIL_SOURCE := ./nxte22_test.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
