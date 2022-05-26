# Target specific macros
TARGET = wavlooptest
TARGET_SOURCES := \
	wavlooptest.c
TOPPERS_OSEK_OIL_SOURCE := ./wavlooptest.oil
WAV_SOURCES := \
	lego_mindstorms_nxt.wav

O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
