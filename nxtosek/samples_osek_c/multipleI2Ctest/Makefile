# Target specific macros
TARGET = multipleI2C
TARGET_SOURCES = \
	sample.c
TOPPERS_OSEK_OIL_SOURCE = ./sample.oil

O_PATH ?= build

ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
