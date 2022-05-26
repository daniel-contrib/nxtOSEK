# Target specific macros
TARGET = wavtest
TARGET_SOURCES := \
	wavtest.c
TOPPERS_OSEK_OIL_SOURCE := ./wavtest.oil
WAV_SOURCES := \
	lego_mindstorms_nxt.wav
BUILD_MODE = ROM_ONLY

O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
