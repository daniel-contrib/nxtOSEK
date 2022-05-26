# Target specific macros
TARGET = RS485_TEST
TARGET_SOURCES = \
	rs485test.c
TOPPERS_OSEK_OIL_SOURCE = ./rs485test.oil

# Don't modify below part
O_PATH ?= build
ifndef NXTOSEK
    NXTOSEK = /usr/local/src/nxtosek
endif
include $(NXTOSEK)/ecrobot/ecrobot.mak
