# Target specific macros
TARGET = HiTechTest
TARGET_SOURCES := \
	hitechtest.c
TOPPERS_OSEK_OIL_SOURCE := ./hitechtest.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
